
set nocompatible                " don't bother with vi compatibility
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atI

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set nobackup                    " do not keep a backup file
set wrap

set noerrorbells                " don't beep
set visualbell                  " turn off error beep/flash
set t_vb=
set tm=500
set relativenumber

set linebreak
set wrapmargin=2
set showmatch

set swapfile
set directory^=$HOME/.swap//
set updatetime=30000
set updatecount=60
set undofile
set undodir=~/.undodir

set lazyredraw

set nofoldenable                " 启动时关闭代码折叠
"za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠

" leader
let mapleader = "\<space>"

"定义以下快捷键，用于快速编辑和重载vimrc配置文件：
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" move to beginning/end of line
nnoremap H ^
nnoremap L $

" syntax
syntax on

" history : how many lines of history VIM has to remember
set history=2000

" filetype
filetype on
" Enable filetype plugins
filetype plugin on
filetype indent on

" Vim-plug
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-easymotion'
    let g:EasyMotion_do_mapping = 0 " Disable default mappings
    " Jump to anywhere you want with minimal keystrokes, with just one key binding.
    " `s{char}{char}{label}`
    " Need one more keystroke, but on average, it may be more comfortable.
    nmap '' <Plug>(easymotion-overwin-f2)
    " Turn on case-insensitive feature
    let g:EasyMotion_smartcase = 1
Plug 'preservim/nerdcommenter'

Plug 'terryma/vim-multiple-cursors'

Plug 'mhinz/vim-startify'
Plug 'Yggdroot/LeaderF'
    let g:Lf_ReverseOrder = 1
    " don't show the help in normal mode
    let g:Lf_HideHelp = 1
    let g:Lf_UseCache = 0
    let g:Lf_UseVersionControlTool = 0
    let g:Lf_IgnoreCurrentBufferName = 1
    " popup mode
    let g:Lf_WindowPosition = 'popup'
    let g:Lf_PreviewInPopup = 1
    let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
    let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

    let g:Lf_ShortcutF = "<leader>f"
    noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
    noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
    noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
    noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

    " noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-bffer -e %s ", expand("<cword>"))<CR>
    " noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
    " search visually selected text literally
    xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
    noremap go :<C-U>Leaderf! rg --recall<CR>

    " should use `Leaderf gtags --update` first
    let g:Lf_GtagsAutoGenerate = 0
    let g:Lf_Gtagslabel = 'native-pygments'
    noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
    noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
    noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
    noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
    noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>u

    " Show icons, icons are shown by default
    let g:Lf_ShowDevIcons = 0
    " For GUI vim, the icon font can be specify like this, for example
    " let g:Lf_DevIconsFont = "DroidSansMono Nerd Font Mono"
    " If needs
    " set ambiwidth=double
Plug 'jalvesaq/Nvim-R'
    let maplocalleader = "\<space>"
    " make R vertical split at start
    let R_rconsole_width = 57
    let R_min_editor_width = 18
    " some nice keybindding, D = cursor down one line when finished the code
    " localleader+rv = view data, +rg = plot(graphic), +rs = summary, all without sending lines to R buffer, very useful
    " Other useful features like Rformat and R RBuildTags aren’t covered here, see Nvim-R for more info.

    " R output is highlighted with current colorscheme
    " let g:rout_follow_colorscheme = 1

    " R commands in R output are highlighted
    " let g:Rout_more_colors = 1
   if has('mac')
        let g:python3_host_prog = '/usr/local/bin/python3'
    endif
Plug 'honza/vim-snippets'  " snippets repository

Plug 'chrisbra/csv.vim'    " for viewing data directly in vim R (Nvim-R)

Plug 'sjl/gundo.vim'
    let g:gundo_prefer_python3 = 1
    nnoremap <leader>u :GundoToggle<CR>
Plug 'ferrine/md-img-paste.vim'
    autocmd FileType html,markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
    let g:mdip_imgdir = '.'
    let g:mdip_imgname = 'image'

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" fix the most annoying bug that coc has
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
let g:coc_global_extensions = [
  \ 'coc-actions',
  \ 'coc-css',
  \ 'coc-diagnostic',
  \ 'coc-explorer',
  \ 'coc-git',
  \ 'coc-html',
  \ 'coc-lists',
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-r-lsp',
  \ 'coc-zi',
  \ 'coc-translator',
  \ 'coc-vimlsp',
  \ 'coc-yank']
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]	=~ '\s'
endfunction
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-o> coc#refresh()

" Open up coc-commands
nnoremap <c-c> :CocCommand<CR>
" Text Objects
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>e :CocCommand explorer<CR>
" coc-translator
nmap tt <Plug>(coc-translator-p)
vmap tt <Plug>(coc-translator-pv)
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" coc-snippets
let g:coc_snippet_next = '<tab>'
xmap <Tab> <Plug>(coc-snippets-select)
" Use <C-p> for trigger snippet expand.
"smap <c-p> <Plug>(coc-snippets-expand)

"Use :CocList snippets to open snippets list.
"Use :CocCommand snippets.editSnippets to edit user snippet of current filetype.
"Use :CocCommand snippets.openSnippetFiles to open snippet files of current filetype.
"Use the command :CocConfig to open your user configuration file
    "snippets.userSnippetsDirectory, Directory that contains custom user ultisnips snippets, use ultisnips in extension root by default. 自定义模板目录

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>a  <Plug>(coc-format)

Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
"<leader>tm to start 

Plug 'theniceboy/eleline.vim'
    let g:airline_powerline_fonts = 1

Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
    let g:Hexokinase_highlighters = ['virtual']

Plug 'RRethy/vim-illuminate'
    let g:Illuminate_delay = 750
    "hi illuminatedWord cterm=undercurl gui=undercurl
    
Plug 'mg979/vim-visual-multi'
    "let g:VM_theme             = 'iceblue'
    "let g:VM_default_mappings = 0
    let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}
    let g:VM_maps                       = {}
    let g:VM_custom_motions             = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
    let g:VM_maps['i']                  = 'k'
    let g:VM_maps['I']                  = 'K'
    let g:VM_maps['Find Under']         = '<C-k>'
    let g:VM_maps['Find Subword Under'] = '<C-k>'
    let g:VM_maps['Find Next']          = ''
    let g:VM_maps['Find Prev']          = ''
    let g:VM_maps['Remove Region']      = 'q'
    let g:VM_maps['Skip Region']        = '<c-n>'
    let g:VM_maps["undo"]               = 'l'
    let g:VM_maps["Redo"]               = '<C-r>'

Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp

Plug 'rhysd/clever-f.vim'

Plug 'MattesGroeger/vim-bookmarks'
let g:bookmark_no_default_key_mappings = 1
nmap mt <Plug>BookmarkToggle
nmap ma <Plug>BookmarkAnnotate
nmap ml <Plug>BookmarkShowAll
nmap mi <Plug>BookmarkNext
nmap mn <Plug>BookmarkPrev
nmap mC <Plug>BookmarkClear
nmap mX <Plug>BookmarkClearAll
nmap mu <Plug>BookmarkMoveUp
nmap me <Plug>BookmarkMoveDown
nmap <Leader>g <Plug>BookmarkMoveToLine
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_manage_per_buffer = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_center = 1
let g:bookmark_auto_close = 1
let g:bookmark_location_list = 1


Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
nmap <C-s> <Plug>MarkdownPreview

call plug#end()

set cursorline

" 设置 alt 键不映射到菜单栏
set winaltkeys=no
" movement
set scrolloff=7                 " keep 7 lines when scrolling

" Vim 的默认寄存器和系统剪贴板共享
" set clipboard+=unnamed

" Copy to system clipboard
vnoremap y "+y

" show
set ruler                       " show the current row and column
set number                      " show line numbers
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis  eol:$
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽
set list

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
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B

" select & complete
set selection=inclusive  "指定在选择文本时，光标所在位置也属于被选中的范围。如果指定 selection=exclusive 的话，可能会出现某些文本无法被选中的情况。

set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class
" 切换缓冲区快捷键
"set wildchar=<Tab> wildcharm=<C-z>
"noremap <c-n> :b <C-z>

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l

" if this not work ,make sure .viminfo is writable for you
" 记住上次退出光标位置
if has("autocmd")
    au bufreadpost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" NOT SUPPORT
" Enable basic mouse behavior such as resizing buffers.
set mouse=a

" ============================ theme and status line ============================

colorscheme gruvbox
set background=dark    " Setting dark mode

" set mark column color 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" status line
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2   " Always show the status line - use 2 lines for the status bar

" ============================ specific file type ===========================

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
" autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown
" autocmd BufRead,BufNew *.Rmd set filetype=rmd

" ============================ key map ============================
" 折叠后移动快捷键修改
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented

" jk 替换 Esc
inoremap jk <Esc>

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remove highlight
noremap <silent><leader>/ :nohls<CR>

"Reselect visual block after indent/outdent.调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" Shift+H goto head of the line, Shift+L goto end of the line
" nnoremap < ^
" nnoremap > $

" save
cmap w!! w !sudo tee >/dev/null %

"改变光标模式

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR ="REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"Cursor settings:

"1 -> blinking block
"2 -> solid block
"3 -> blinking underscore
"4 -> solid underscore
"5 -> blinking vertical bar
"6 -> solid vertical bar

"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"


" 解决 tmux 真彩问题
set termguicolors
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Goyo
nnoremap <leader>g :Goyo<CR>

let g:goyo_width = 120
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  " Limelight
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=7
  " Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" Swap up and down == for indent
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

nnoremap ; :
nnoremap U <C-r>
nnoremap ' `
nnoremap ` '

nnoremap H <c-w>h
nnoremap L <c-w>l
nnoremap K <c-w>k
nnoremap M <c-w>j


autocmd FileType markdown hi link markdownError NONE

" radian Nvim-R support
" R version can be specified like this:
" let vimrplugin_r_path = "/opt/R/3.1.2-release/bin/R"
" Send selection or line to R with space bar, respectively.
" vmap <Space>l <Plug>RDSendSelection
" nmap <Space>l <Plug>RDSendLine

"let R_app = "radian"
"let R_cmd = "R"
"let R_hl_term = 0
"let R_args = []  " if you had set any
"let R_bracketed_paste = 1

noremap <c-g> :tabe<CR>:-tabmove<CR>:term lazygit<CR>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap si :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sk :set splitbelow<CR>:split<CR>
noremap sj :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Press ` to change case (instead of ~)
noremap ` ~

" find and replace
noremap fr :%s//g<left><left>


nnoremap <leader>v :exe ':silent !open -a /Applications/Google\ Chrome.app %'<CR>

"参数换行
nmap aa :s/\(\w\+ *=\)/\r\1/g<CR>

noremap <leader>o o<CR><ESC>ki


