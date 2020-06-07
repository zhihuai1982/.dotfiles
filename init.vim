
set nocompatible                " don't bother with vi compatibility
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atI

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set nobackup                    " do not keep a backup file
set wrap

set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell                  " turn off error beep/flash
set t_vb=
set tm=500
set relativenumber

set linebreak
set wrapmargin=2
set showmatch

set swapfile
set updatetime=30000
set updatecount=60
set noundofile

set nofoldenable                " 启动时关闭代码折叠
"za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠

" leader
let mapleader = "\<space>"

"定义以下快捷键，用于快速编辑和重载vimrc配置文件：
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

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
" Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
" Plug 'gabrielelana/vim-markdown'
    " let g:markdown_enable_spell_checking = 0
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
    map <leader>n :NERDTreeToggle<CR>
    Plug 'scrooloose/nerdcommenter'
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-l    ine comments
    let g:NERDCompactSexyComs = 1
    let g:NERDDefaultAlign = 'left'
    " Align line-wise comment delimiters flush left instead of following code indentation
    " Add your own custom formats or override the defaults
    let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
    " Enable NERDCommenterToggle to check all selected lines is commented or not
    let g:NERDToggleCheckAllLines = 1
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-easymotion'
    let g:EasyMotion_do_mapping = 0 " Disable default mappings
    " Jump to anywhere you want with minimal keystrokes, with just one key binding.
    " `s{char}{char}{label}`
    " Need one more keystroke, but on average, it may be more comfortable.
    nmap <Leader>s <Plug>(easymotion-overwin-f2)
    " Turn on case-insensitive feature
    let g:EasyMotion_smartcase = 1
    " JK motions: Line motions
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
" Plug 'terryma/vim-multiple-cursors'      " ctrl+n, ctrl+p, ctrl+x, Esc
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
    let g:rout_follow_colorscheme = 1

    " R commands in R output are highlighted
    let g:Rout_more_colors = 1
Plug 'ncm2/ncm2'           " snippet engine
Plug 'roxma/nvim-yarp'      " dependency
    if has('mac')
        let g:python3_host_prog = '/usr/local/bin/python3'
    endif
    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()
    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect
        " suppress the annoying 'match x of y', 'The only match' and 'Pattern not
    " found' messages
    set shortmess+=c
    " CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
    inoremap <c-c> <ESC>
    " When the <Enter> key is pressed while the popup menu is visible, it only
    " hides the menu. Use this mapping to close the menu and also start a new
    " line.
    " inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
    " Use <TAB> to select the popup menu:
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " wrap existing omnifunc
    " Note that omnifunc does not run in background and may probably block the
    " editor. If you don't want to be blocked by omnifunc too often, you could
    " add 180ms delay before the omni wrapper:
    "  'on_complete': ['ncm2#on_complete#delay', 180,
    "               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
    au user Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'css',
            \ 'priority': 9,
            \ 'subscope_enable': 1,
            \ 'scope': ['css','scss'],
            \ 'mark': 'css',
            \ 'word_pattern': '[\w\-]+',
            \ 'complete_pattern': ':\s*',
            \ 'on_complete': ['ncm2#on_complete#delay', 180,
             \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
            \ })
Plug 'sirVer/ultisnips'    " snippet engine
Plug 'ncm2/ncm2-ultisnips' " based on ultisnips

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
    " press enter key to trigger snippet expansion
    " the parameters are the same as `:help feedkeys()`
    inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
    " let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
    let g:UltiSnipsExpandTrigger="<c-0>"
    let g:UltiSnipsJumpForwardTrigger	= "<c-f>"
    let g:UltiSnipsJumpBackwardTrigger	= "<c-b>"
    " let g:UltiSnipsRemoveSelectModeMappings = 0k
Plug 'gaalcaras/ncm-R'     " It relies on the great plugin nvim-R to get the completion data and extends ncm2 for the completion.
Plug 'honza/vim-snippets'  " snippets repository
Plug 'chrisbra/csv.vim'    " for viewing data directly in vim R (Nvim-R)
"Plug 'iamcco/markdown-preview.vim' " Vim 寫 MarkDown 並在瀏覽器同步並檢視文件
" Plug 'w0rp/ale' " 程式碼靜態檢查，程式碼格式修正"
" Plug 'lfv89/vim-interestingwords' " 高亮感興趣的當前單詞
" Plug 'jpalardy/vim-slime'
"     let g:slime_target = "tmux"
"     let g:slime_paste_file = "$HOME/.slime_paste"
"     " let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}
"     let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
" Plug 'Chiel92/vim-autoformat'
Plug 'dense-analysis/ale'
    " let g:ale_linters = {'r': ['lintr']}
    let g:ale_r_lintr_options = "with_defaults(line_length_linter(120))"
    let g:ale_r_lintr_lint_package = 1
    let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'r': ['styler'],
    \}
    let g:ale_fix_on_save = 1
    let g:airline#extensions#ale#enabled = 1
call plug#end()


set nocursorcolumn
set nocursorline

" 设置 alt 键不映射到菜单栏
set winaltkeys=no
" movement
set scrolloff=7                 " keep 7 lines when scrolling

" Vim 的默认寄存器和系统剪贴板共享
set clipboard+=unnamed

" show
set ruler                       " show the current row and column
set number                      " show line numbers
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽
set list

" search
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " no ignorecase if Uppercase char present

" tab
set expandtab                   " expand tabs to spaces
set smarttab
set shiftround

" indent
set autoindent smartindent shiftround
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
set wildchar=<Tab> wildcharm=<C-z>
noremap <c-n> :b <C-z>

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l

" if this not work ,make sure .viminfo is writable for you
" 记住上次退出光标位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
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
autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown
autocmd BufRead,BufNew *.Rmd set filetype=rmd
autocmd BufRead,BufNew *.R set filetype=r

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

" Quickly close the current window
nnoremap <leader>q :q<CR>
"nnoremap <leader>Q :q!<CR>
" Quickly save the current file
nnoremap <leader>w :w<CR>

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
nnoremap H ^
nnoremap L $

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

" window change
" nnoremap <C-j> <C-w><C-j>
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

autocmd FileType markdown hi link markdownError NONE

" radian Nvim-R support
" R version can be specified like this:
" let vimrplugin_r_path = "/opt/R/3.1.2-release/bin/R"
" Send selection or line to R with space bar, respectively.
" vmap <Space>l <Plug>RDSendSelection
" nmap <Space>l <Plug>RDSendLine

let R_app = "radian"
let R_cmd = "R"
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 1

vmap ts :Rformat<CR>
