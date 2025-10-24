#!/bin/bash
# 配置参数
if [ -z "$1" ]; then
  echo "用法: $0 <stream_url> [output_prefix]"
  echo "例如: $0 https://example.com/stream.m3u8 my_stream"
  exit 1
fi

STREAM_URL="$1"                                  # 从命令行参数获取视频流地址
OUTPUT_DIR="/home/zhihuai1982/livestreaming-nfs" # 输出目录
RETRY_DELAY=5                                    # 失败后等待5秒再重试
MAX_RETRIES=100                                  # 最大重试次数（0为无限）

# 设置输出文件前缀，如果提供了第二个参数则使用它，否则使用默认的"output"
OUTPUT_PREFIX="output"
if [ -n "$2" ]; then
  OUTPUT_PREFIX="$2"
fi

# 确保输出目录存在
# mkdir -p "$OUTPUT_DIR"

# 初始化重试计数器
retry_count=0

# 循环下载
while true; do
  # 生成当前时间戳的文件名
  OUTPUT_FILE="$OUTPUT_DIR/$(date +"%Y-%m-%d")-${OUTPUT_PREFIX}-$(date +"%Y%m%d-%H%M%S").mp4"

  echo "=== 开始下载（第 $((retry_count + 1)) 次尝试）==="
  echo "=== 下载地址: $STREAM_URL ==="
  echo "=== 保存文件: $OUTPUT_FILE ==="

  # 执行ffmpeg下载（带续传和重连参数）
  ffmpeg -i "$STREAM_URL" \
    -c copy \
    -nostdin \
    -reconnect 1 \
    -reconnect_delay_max 10 \
    -timeout 30 \
    "$OUTPUT_FILE"

  # 检查ffmpeg退出状态（0=成功，非0=失败）
  exit_code=$?
  if [ $exit_code -eq 0 ]; then
    echo "=== 下载完成！==="
    break # 成功则退出循环
  else
    echo "=== 下载失败（退出码：$exit_code），$RETRY_DELAY 秒后重试 ==="
    retry_count=$((retry_count + 1))
    # 检查是否超过最大重试次数
    if [ $MAX_RETRIES -ne 0 ] && [ $retry_count -ge $MAX_RETRIES ]; then
      echo "=== 已达到最大重试次数（$MAX_RETRIES），退出 ==="
      break
    fi
    sleep $RETRY_DELAY # 等待后重试
  fi
done
