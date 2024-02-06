"----------------------------------------------------------------------
" Set
"----------------------------------------------------------------------
set nocompatible                " don't bother with vi compatibility
set hidden                      " 允许 vim 未保存 跳转 buffer
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=ati

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title

set nrformats = " 所有数字都认为是十进制

set wrap "我们可以告诉Vim在合适的地方折行：
set linebreak "所谓合适的地方，是由breakat选项中的字符来确定的。在默认的情况下，这些字符是“^I!@*-+_;:,./?”。如果我们不希望在下划线处打断句子，只要用下面的命令将“_”从这个列表移除就可以了： 
set breakat-=_ "如果一行被打断，Vim可能不会在句子连接处显示任何内容。我们可以通过设置showbreak选项，来显示所希望的指示信息：
set showbreak=>

set noerrorbells                " don't beep
set visualbell                  " turn off error beep/flash
set vb t_vb=
set tm=500

set relativenumber

set textwidth=0
set wrapmargin=2
set showmatch

" 显示括号匹配的时间
set matchtime=2

"Disable "bracketed paste mode" by clearing 't_BE'
"防止 vim 把粘贴内容当成输入
set t_BE=

" history : how many lines of history VIM has to remember
set history=2000

" show
set ruler                       " show the current row and column
set number                      " show line numbers
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis  eol:$

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m

" 合并两行中文时，不在中间加空格
set formatoptions+=B

" 文件换行符，默认使用 unix 换行符
set ffs=unix,dos,mac

" 显示最后一行
set display=lastline
set laststatus=2

" search
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " no ignorecase if Uppercase char present

" tab
set smarttab
set expandtab                   " expand tabs to spaces
set shiftround

" indent
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4                " insert mode tab and backspace use 4 spaces

" encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8

" select & complete
set selection=inclusive  "指定在选择文本时，光标所在位置也属于被选中的范围。如果指定 selection=exclusive 的话，可能会出现某些文本无法被选中的情况。

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
"set whichwrap+=<,>,h,l

" NOT SUPPORT
" Enable basic mouse behavior such as resizing buffers.
set mouse=a

"E363: pattern uses more memory than ‘maxmempattern’
" vim searching error
set maxmempattern=90000

"----------------------------------------------------------------------
" 备份设置
"----------------------------------------------------------------------

" 允许备份
set backup

" 保存时备份
set writebackup

" 备份文件地址，统一管理
set backupdir=~/.vim/tmp

" 备份文件扩展名
set backupext=.bak

" 禁用交换文件
set noswapfile

" 禁用 undo文件
set noundofile

" 创建目录，并且忽略可能出现的警告
silent! call mkdir(expand('~/.vim/tmp'), "p", 0755)

set updatetime=300
set updatecount=60

" 延迟绘制（提升性能）
set lazyredraw

" 错误格式
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m

" 设置分隔符可视
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

set nofoldenable                " 启动时关闭代码折叠
"za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠


set cursorline

" 设置 alt 键不映射到菜单栏
set winaltkeys=no

" movement
set scrolloff=7                 " keep 7 lines when scrolling

"Centering with scrolloff
"https://vim.fandom.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen
"set scrolloff=999

" 如果是 set startofline 的话，翻页或者 gg/G 等会将光标移到行首第一个非空字符
set nostartofline

" Vim 的默认寄存器和系统剪贴板共享
set clipboard+=unnamed

"----------------------------------------------------------------------
" 文件类型设置
"----------------------------------------------------------------------

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai

" 防止 markdown 空格红色
autocmd FileType markdown,rmd hi link markdownError NONE

" 文件搜索和补全时忽略下面扩展名
set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,list,full
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android

" syntax
syntax enable
syntax on
" filetype
filetype on
" Enable filetype plugins
filetype plugin on
filetype indent on

au BufRead,BufNewFile *.luna set filetype=luna

"----------------------------------------------------------------------
" Leader
"----------------------------------------------------------------------

let mapleader = "\<space>"

"----------------------------------------------------------------------
" Vim-plug
"----------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
    let g:gruvbox_italic = '1'

Plug 'godlygeek/tabular'
    "http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
    "选中需要对齐的区块  然后输入:tabu<tab> /: \zs
    nmap <Leader>a\ :Tabularize /\|<CR>
    vmap <Leader>a\ :Tabularize /\|<CR>
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a; :Tabularize /:\zs<CR>
    vmap <Leader>a; :Tabularize /:\zs<CR>
    nmap <Leader>al :Tabularize /
    vmap <Leader>al :Tabularize /

Plug 'machakann/vim-sandwich'
    " NOTE: To prevent unintended operation, the following setting is strongly recommended to add to your vimrc.
    " |s| could be easily replaced by |c|l| commands.k
	nmap s <Nop>
	xmap s <Nop>


Plug 'wellle/targets.vim'

Plug 'junegunn/vim-slash'
    "改善"/"搜索体验
    "vim-slash provides a set of mappings for enhancing in-buffer search experience in Vim.
    "Automatically clears search highlight when cursor is moved
    "Improved star-search (visual-mode, highlighting without moving)

"Plug 'psliwka/vim-smoothie'

Plug 'unblevable/quick-scope'
    " Trigger a highlight in the appropriate direction when pressing these keys:
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
    augroup END

Plug 'easymotion/vim-easymotion'
    "let g:EasyMotion_do_mapping = 0 " Disable default mappings
    let g:EasyMotion_smartcase = 1

    "For symbols and numerals. 1 will match 1 and !; ! matches ! only.
    let g:EasyMotion_use_smartsign_us = 1 " US layout
    map s <Plug>(easymotion-overwin-f)

    " Gif config
    map  / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-tn)

    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)

Plug 'preservim/nerdcommenter'
    vmap <Leader>cc <Plug>NERDCommenterToggle
    nmap <Leader>cc <Plug>NERDCommenterToggle
    let g:NERDCustomDelimiters = { 'luna': { 'left': '% '} }

Plug 'moll/vim-bbye'
    "Bbye allows you to do delete buffers (close files) without closing your windows or messing up your layout.
    "Vim by default closes all windows that have the buffer (file) open when you do :bdelete. If you've just got your splits and columns perfectly tuned, having them messed up equals a punch in the face and that's no way to tango.
    
Plug 'mhinz/vim-startify'

"Plug 'Yggdroot/LeaderF'
    "let g:Lf_ReverseOrder = 1
    "" don't show the help in normal mode
    "let g:Lf_HideHelp = 1
    "let g:Lf_UseCache = 0
    "let g:Lf_UseVersionControlTool = 0
    "let g:Lf_IgnoreCurrentBufferName = 1
    "" popup mode
    "let g:Lf_WindowPosition = 'popup'
    "let g:Lf_PreviewInPopup = 1
    "let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
    "let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
    "let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
    "let g:Lf_ShowHidden = 0

    "let g:Lf_ShortcutF = "<leader>ff"

    """"""""""""""""""""""
    ""use :Leaderf <subcommand> -h to get specific help of subcommand, e.g., :Leaderf rg -h
    """"""""""""""""""""""
    "noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
    ""noremap <leader>fv :<C-U><C-R>=printf("Leaderf file %s %s/.dotfiles/", "", getenv("HOME"))<CR><CR>
    "noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
    ""noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
    "noremap <leader>fh :<C-U><C-R>=printf("Leaderf! rg --max-filesize 500K --wd-mode 'Ac' -e %s ", expand("<cword>"))<CR><CR>
    ""noremap <leader>fk :<C-U><C-R>=printf("Leaderf file %s ", "")<CR><CR>
    ""--wd-mode <MODE>      Specify the working directory mode, value has the same meaning as g:Lf_WorkingDirectoryMode.
    ""noremap <leader>fg :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
    "noremap <leader>fj :<C-U>Leaderf rg --max-filesize 500K<CR>
    "" search visually selected text literally
    ""xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
    "noremap go :<C-U>Leaderf! rg --recall<CR>

    "" Show icons, icons are shown by default
    "let g:Lf_ShowDevIcons = 0

"Plug 'jalvesaq/Nvim-R', {'for': ['r','rmarkdown']}
    "let maplocalleader = ","
    "" make R vertical split at start
    "let R_rconsole_width = 57
    "let R_min_editor_width = 18

    "nmap <silent> <LocalLeader>sl :call RAction("levels")<CR>
    "vmap <silent> <LocalLeader>sl :call RAction("levels", "v")<CR>
    "nmap <silent> <LocalLeader>st :call RAction("table")<CR>
    "vmap <silent> <LocalLeader>st :call RAction("table", "v")<CR>
    "nmap <silent> <LocalLeader>sh :call RAction("head")<CR>
    "vmap <silent> <LocalLeader>sh :call RAction("head", "v")<CR>
    "nmap <silent> <LocalLeader>sk :call RAction("topleft")<CR>
    "vmap <silent> <LocalLeader>sk :call RAction("topleft", "v")<CR>
    "nmap <silent> <LocalLeader>sm :call RAction("summary")<CR>
    "vmap <silent> <LocalLeader>sm :call RAction("summary", "v")<CR>
    "nmap <silent> <LocalLeader>sc :call RAction("class")<CR>
    "vmap <silent> <LocalLeader>sc :call RAction("class", "v")<CR>
    "nmap <silent> <LocalLeader>sp :call RAction("typeof")<CR>
    "vmap <silent> <LocalLeader>sp :call RAction("typeof", "v")<CR>
    "nmap <silent> <LocalLeader>sn :call RAction("names")<CR>
    "vmap <silent> <LocalLeader>sn :call RAction("names", "v")<CR>
    "nmap <silent> <LocalLeader>sb :call RAction("dim")<CR>
    "vmap <silent> <LocalLeader>sb :call RAction("dim", "v")<CR>
    "nmap <silent> <LocalLeader>si :call RAction("unique")<CR>
    "vmap <silent> <LocalLeader>si :call RAction("unique", "v")<CR>
    "nmap <silent> <LocalLeader>sr :RSend library("colorout")<CR>
    "nmap <LocalLeader>sw :RSend 
    ""nmap <LocalLeader>sk :<C-U><C-R>=printf("RSend %s[1:5, 1:5]", expand("<cword>"))<CR><CR>

    "" some nice keybindding, D = cursor down one line when finished the code
    "" localleader+rv = view data, +rg = plot(graphic), +rs = summary, all without sending lines to R buffer, very useful
    "" Other useful features like Rformat and R RBuildTags aren’t covered here, see Nvim-R for more info.

    "" R output is highlighted with current colorscheme
    "" let g:rout_follow_colorscheme = 1

    "" R commands in R output are highlighted
    "" let g:Rout_more_colors = 1

"Plug 'vim-scripts/argtextobj.vim'

Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1

Plug 'sjl/gundo.vim'
    let g:gundo_prefer_python3 = 1
    nnoremap <leader>u :GundoToggle<CR><CR>

Plug 'voldikss/vim-floaterm'
    " Set floaterm window background to gray once the cursor moves out from it
    hi FloatermNC guibg=gray

    "nnoremap   <silent>   <leader>tw    :FloatermNew<CR>
    "tnoremap   <silent>   <leader>tw    <C-\><C-n>:FloatermNew<CR>
    "nnoremap   <silent>   <leader>tp    :FloatermPrev<CR>
    "tnoremap   <silent>   <leader>tp    <C-\><C-n>:FloatermPrev<CR>
    "nnoremap   <silent>   <leader>tn    :FloatermNext<CR>
    "tnoremap   <silent>   <leader>tn    <C-\><C-n>:FloatermNext<CR>
    nnoremap   <silent>   <leader>tf   :FloatermToggle<CR>
    tnoremap   <silent>   <leader>tf   <C-\><C-n>:FloatermToggle<CR>
    nnoremap   <silent>   <leader>tk    :FloatermKill<CR>
    tnoremap   <silent>   <leader>tk    <C-\><C-n>:FloatermKill<CR>
    nnoremap   <silent>   <leader>ta    :FloatermNew ranger<CR>
    tnoremap   <silent>   <leader>ta    <C-\><C-n>:FloatermNew ranger<CR>


Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-pairs',
    \ 'coc-highlight',
    \ 'coc-explorer',
    \ 'coc-git',
    \ 'coc-json',
    \ 'coc-html',
    \ 'coc-lists',
    \ 'coc-python',
    \ 'coc-zi',
    \ 'coc-translator',
    \ 'coc-vimlsp',
    \ 'coc-yank']

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    inoremap <silent><expr> <c-u> coc#refresh()

    " Open up coc-commands
    nnoremap <c-c> :CocCommand<CR>

    " Useful commands
    nnoremap <silent> <space>y :<C-u>CocList --normal yank<cr>

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " coc-translator
    nmap <leader>vv <Plug>(coc-translator-e)
    vmap <leader>vv <Plug>(coc-translator-ev)


Plug 'itchyny/lightline.vim'
    let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status'
    \ },
    \ }

    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

Plug 'RRethy/vim-illuminate'
    "Vim plugin for automatically highlighting other uses of the current word under the cursor
    let g:Illuminate_delay = 250
    let g:Illuminate_highlightUnderCursor = 0
    "hi illuminatedWord cterm=undercurl gui=undercurl
    hi link illuminatedWord Visual
    
Plug 'mg979/vim-visual-multi'
    let g:VM_theme             = 'iceblue'
    let g:VM_show_warnings = 1

Plug 'gcmt/wildfire.vim'

Plug 'KabbAmine/vZoom.vim', {'on': ['<Plug>(vzoom)', 'VZoomAutoToggle']}

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
    "autocmd! User vim-which-key call which_key#register(',', 'g:which_key_localmap')
    nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
    vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
    nnoremap <silent> <localleader> :silent <c-u> :silent WhichKey  ","<CR>
    vnoremap <silent> <localleader> :silent <c-u> :silent WhichKeyVisual ','<CR>
    " Map leader to which_key

    " Create map to add keys to
    let g:which_key_map = {}
    "let g:which_key_localmap = {}

    " Define a separator
    let g:which_key_sep = '→'

    " set timeoutlen=100

    " Not a fan of floating windows for this
    let g:which_key_use_floating_win = 0

    " Change the colors if you want
    highlight default link WhichKey          Operator
    highlight default link WhichKeySeperator DiffAdded
    highlight default link WhichKeyGroup     Identifier
    highlight default link WhichKeyDesc      Function

    " Hide status line
    autocmd! FileType which_key
    autocmd  FileType which_key set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

    " Single mappings
    let g:which_key_map[','] = [ ':vsp $MYVIMRC'                 , 'edit init' ]
    nnoremap <silent> <leader>. :source $MYVIMRC<CR>:noh<CR>
    let g:which_key_map['.'] = 'source init'
    let g:which_key_map['='] = [ '<C-W>='                        , 'balance windows' ]
    let g:which_key_map['e'] = [ ':CocCommand explorer'           , 'explorer' ]
    noremap <silent> <leader>/ :nohls<CR>
    let g:which_key_map['/'] = 'remove highlight'
    let g:which_key_map['k'] = [ ':m .-2<CR>=='                  , 'line up']
    let g:which_key_map['j'] = [ ':m .+1<CR>=='                  , 'line down']
    noremap <leader>o o<CR><ESC>ki
    let g:which_key_map.o = 'insert line'
    let g:which_key_map['u'] = [ ':UndotreeToggle<CR>'               , 'undo tree']
    nnoremap <silent> <leader>z :VZoomAutoToggle<CR>
    "let g:which_key_map['p'] = [ '<Plug>MarkdownPreview'         , 'md preview' ]
    let g:which_key_map['z'] = [ ':VZoomAutoToggle<CR>'           , 'zoom' ]

    noremap <silent> <leader>q :Bdelete<CR>
    let g:which_key_map.q = 'which_key_ignore'
    noremap <silent> <leader>Q :q!<CR>
    noremap <silent> Q :q!<CR>
    let g:which_key_map.Q = 'which_key_ignore'
    noremap <silent> <leader>qq :q<CR>
    let g:which_key_map.qq = 'which_key_ignore'
    noremap <silent> <leader>w :w<CR>
    let g:which_key_map.w = 'which_key_ignore'
    noremap <silent> <leader>wq :wq<CR>
    let g:which_key_map.wp = 'which_key_ignore'


    noremap <silent> <leader>br :vsp<CR>:bprevious<CR>
    let g:which_key_map.b = {
        \ 'name' : '+buffer' ,
        \ '1' : ['b1'        , 'buffer 1']        ,
        \ '2' : ['b2'        , 'buffer 2']        ,
        \ 'd' : ['bd'        , 'delete-buffer']   ,
        \ 'f' : ['bfirst'    , 'first-buffer']    ,
        \ 'h' : ['startify'  , 'home-buffer']     ,
        \ 'l' : ['blast'     , 'last-buffer']     ,
        \ 'n' : ['bnext'     , 'next-buffer']     ,
        \ 'p' : ['bprevious' , 'previous-buffer'] ,
        \ '?' : ['buffers'   , 'fzf-buffer']      ,
        \ }

call plug#end()

"----------------------------------------------------------------------
" setting of sandwich
"----------------------------------------------------------------------
" it would be better to copy the default settings in g:sandwich#default_recipes
" due to vim-plug delay loading, the sandwich#recipes need to add after plug#end
"
" help url https://github.com/machakann/vim-sandwich

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
                \ {
                \ 'buns'       : ['```', '```'],
                \ 'kind'       : ['add','delete'],
                \ 'input'      : ['c'],
                \  },
                \ ]
let g:sandwich#recipes += [
                \ {
                \ 'buns'       : ['==', '=='],
                \ 'kind'       : ['add','delete'],
                \ 'input'      : ['d'],
                \  },
                \ ]

"----------------------------------------------------------------------
" 显示设置
"----------------------------------------------------------------------

" 这一行要在前面
colorscheme gruvbox

"改变光标模式
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR ="REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

" set mark column color 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" background transpant
hi Normal guibg=NONE ctermbg=NONE

" 解决 tmux 真彩问题
set termguicolors
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if has('mac')
        let g:python3_host_prog = '/Users/zhihuai1982/miniconda3/bin/python3'
    endif

"----------------------------------------------------------------------
" 键盘映射
"----------------------------------------------------------------------

" copy to system clipboard
vnoremap y "+y

" 折叠后移动快捷键修改
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" save
cmap w!! w !sudo tee >/dev/null %

" 光标在窗口内移动
nnoremap H <c-w>h
nnoremap L <c-w>l
nnoremap K <c-w>k
nnoremap M <c-w>j

"nnoremap K Hzb
"nnoremap M Lzt

" Resize splits with arrow keys
"noremap <up> :res +5<CR>
"noremap <down> :res -5<CR>
noremap <left> <c-w>h:vertical resize-5<CR>
noremap <right> <c-w>h:vertical resize+5<CR>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap <leader>sb :set splitbelow<CR>:split<CR>
noremap <leader>sr :w<CR>:set splitright<CR>:vsplit<CR>:Startify<CR>
" Place the two screens up and down
noremap <leader>sh <C-w>t<C-w>K
" Place the two screens side by side
noremap <leader>sv <C-w>t<C-w>H

" Press ` to change case (instead of ~)
noremap ` ~

" jump to end of line while in Insert Mode
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
