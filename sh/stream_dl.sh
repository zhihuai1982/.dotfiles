#!/bin/bash
# 可中断续传下载脚本 v2.1 (MKV实时写入)
# 优化重点：中断立即保留文件，支持后续手动续传

# 参数检查
if [[ $# -lt 1 ]]; then
  echo -e "\e[31m错误：必须提供视频流URL\e[0m"
  echo "使用示例："
  echo "  ./resumable_dl.sh 'https://...flv?volcTime=...'"
  echo "  ./resumable_dl.sh 流地址URL 输出文件名.mkv"
  exit 1
fi

# 配置参数
MAX_RETRY=5                                        # 网络错误最大重试次数
INCOMPLETE_SUFFIX=".part"                          # 未完成文件后缀
LOG_DIR="$HOME/Downloads/stream_logs"              # 日志存放目录
DOWNLOAD_DIR="/home/zhihuai1982/livestreaming-nfs" # 修改为指定的下载目录

# 初始化
mkdir -p "$LOG_DIR"
mkdir -p "$DOWNLOAD_DIR" # 确保下载目录存在
LOG_FILE="${LOG_DIR}/$(date +%Y%m%d_%H%M%S).log"
touch "$LOG_FILE"

# 生成输出文件名
generate_filename() {
  local url="$1"
  local ts=$(date +%m%d_%H%M)
  local filename=$(echo "${url%%\?*}" | awk -F/ '{split($NF,a,".");print a[1] "_'$ts'.mkv"}')
  echo "$DOWNLOAD_DIR/$filename" # 加入下载目录路径
}

# 日志记录
log() {
  local status=$1
  local message=$2
  echo -e "[$(date '+%H:%M:%S')] \e[33m${status}\e[0m $message" | tee -a "$LOG_FILE"
}

# 信号捕获处理
trap_handler() {
  log "中断" "用户主动终止，已下载内容保存在: $OUTPUT_FILE"
  exit 130
}
trap trap_handler INT TERM

# 下载执行
main() {
  local url="$1"
  local output_file="${2:-$(generate_filename "$url")}"

  # 如果提供了第二个参数但没有包含完整路径，则添加下载目录
  if [[ $# -ge 2 && ! "$output_file" == /* && ! "$output_file" == ./* ]]; then
    output_file="$DOWNLOAD_DIR/$output_file"
  fi

  local temp_file="${output_file}${INCOMPLETE_SUFFIX}"

  log "开始" "URL: $url"
  log "输出" "目标文件: $output_file"

  for ((retry = 1; retry <= MAX_RETRY; retry++)); do
    if [[ -f "$temp_file" ]]; then
      local resume_point=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$temp_file" 2>/dev/null | cut -d. -f1)
      resume_point=${resume_point:-0}
      log "恢复" "从 ${resume_point} 秒处续传"
    fi

    ffmpeg -hide_banner \
      -reconnect 1 \                   # 启用自动重连
    -reconnect_at_eof 1 \              # 在文件结束时重连
    -reconnect_streamed 1 \            # 流式传输重连
    -reconnect_delay_max 60 \          # 最大重试间隔（秒）
    -reconnect_delay_total_max 3600 \  # 总重试时间（秒）
    -timeout 5000000 \                 # 超时设置（微秒）
    -rw_timeout 3000000 \
      -user_agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
      -ss "${resume_point:-0}" -i "$url" \
      -c copy -f matroska \
      -y "$temp_file" 2>&1 | tee -a "$LOG_FILE"

    case "${PIPESTATUS[0]}" in
    0)
      mv "$temp_file" "$output_file"
      log "完成" "文件已保存 → $output_file"
      return 0
      ;;
    *)
      log "错误" "第${retry}次尝试失败，等待重试..."
      sleep $((retry * 5))
      ;;
    esac
  done

  log "失败" "已达到最大重试次数，保留未完成文件: $temp_file"
  return 1
}

main "$@"
