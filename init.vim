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


" syntax
syntax on

" history : how many lines of history VIM has to remember
set history=2000

set nobackup                    " do not keep a backup file
set swapfile
set directory^=$HOME/.swap//
set updatetime=300
set updatecount=60
set undofile
set undodir=~/.undodir

set lazyredraw

set nofoldenable                " 启动时关闭代码折叠
"za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠

set cursorline

" 设置 alt 键不映射到菜单栏
set winaltkeys=no
" movement
set scrolloff=7                 " keep 7 lines when scrolling

" Vim 的默认寄存器和系统剪贴板共享
" set clipboard+=unnamed

" 解决 tmux 真彩问题
set termguicolors
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" show
set ruler                       " show the current row and column
set number                      " show line numbers
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis  eol:$
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽

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

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
"set whichwrap+=<,>,h,l

" NOT SUPPORT
" Enable basic mouse behavior such as resizing buffers.
set mouse=a

" leader

let mapleader = "\<space>"

" filetype
filetype on
" Enable filetype plugins
filetype plugin on
filetype indent on

" Vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
    let g:gruvbox_italic = '1'

Plug 'junegunn/goyo.vim', {'for': 'markdown'}
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
    endfunction

    function! s:goyo_leave()
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    set showmode
    set showcmd
    set scrolloff=7
    endfunction

    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()

Plug 'godlygeek/tabular'
    "http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
    "选中需要对齐的区块  然后输入:tabu<tab> /: \zs

"Plug 'tpope/vim-surround'
    "cs"'
    "ds"
    "ysiw"   word
    "yss"    whole sentence
    "yssb    (sentence)
    "visual mode  "S"

Plug 'machakann/vim-sandwich'
	nmap s <Nop>
	xmap s <Nop>
    "Add
    "Press sa{motion/textobject}{addition}. For example, a key sequence saiw( makes foo to (foo).

    "Delete
    "Press sdb or sd{deletion}. For example, key sequences sdb or sd( makes (foo) to foo. sdb searches a set of surrounding automatically.

    "Replace
    "Press srb{addition} or sr{deletion}{addition}. For example, key sequences srb" or sr(" makes (foo) to "foo".

Plug 'wellle/targets.vim'

Plug 'junegunn/vim-slash'

Plug 'psliwka/vim-smoothie'

Plug 'unblevable/quick-scope'
    " Trigger a highlight in the appropriate direction when pressing these keys:
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
    augroup END

Plug 'Lokaltog/vim-easymotion'
    let g:EasyMotion_do_mapping = 0 " Disable default mappings
    let g:EasyMotion_smartcase = 1
    nmap m <Plug>(easymotion-overwin-f2)

Plug 'preservim/nerdcommenter'
    let g:NERDCreateDefaultMappings = 0
    nmap <Leader>cc <Plug>NERDCommenterToggle
    vmap <Leader>cc <Plug>NERDCommenterToggle

Plug 'moll/vim-bbye'

Plug 'mhinz/vim-startify'

Plug 'airblade/vim-rooter'
    "let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']
    let g:rooter_silent_chdir = 1

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
    let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
    let g:Lf_ShowHidden = 0

    let g:Lf_ShortcutF = "<leader>ff"
    let g:Lf_ShortcutB = "<leader>bb"
    noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
    noremap <leader>fv :<C-U><C-R>=printf("Leaderf file %s %s/.dotfiles/", "", getenv("HOME"))<CR><CR>
    noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
    noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
    noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

    noremap <leader>fj :<C-U><C-R>=printf("Leaderf! rg --max-filesize 500K --wd-mode 'Ac' -e %s ", expand("<cword>"))<CR><CR>
    noremap <leader>fg :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
    noremap <leader>fh :<C-U>Leaderf rg --max-filesize 500K<CR>
    " search visually selected text literally
    xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
    noremap go :<C-U>Leaderf! rg --recall<CR>

    " should use `Leaderf gtags --update` first
    " ubuntu下需要把 g:Lf_Gtagsconf='/usr/local/share/gtags/gtags.conf'，或者把这个文件拷贝到自己目录下，重命名为.globalrc，否则不能生成tags。
    let g:Lf_GtagsAutoGenerate = 1
    let g:Lf_Gtagslabel = 'native-pygments'
    let g:Lf_Gtagsconf='/usr/local/share/gtags/gtags.conf'
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

Plug 'jalvesaq/Nvim-R', {'for': ['r','rmarkdown']}
    let maplocalleader = ","
    " make R vertical split at start
    let R_rconsole_width = 57
    let R_min_editor_width = 18

    nmap <silent> <LocalLeader>sl :call RAction("levels")<CR>
    vmap <silent> <LocalLeader>sl :call RAction("levels", "v")<CR>
    nmap <silent> <LocalLeader>st :call RAction("table")<CR>
    vmap <silent> <LocalLeader>st :call RAction("table", "v")<CR>
    nmap <silent> <LocalLeader>sh :call RAction("head")<CR>
    vmap <silent> <LocalLeader>sh :call RAction("head", "v")<CR>
    nmap <silent> <LocalLeader>sk :call RAction("topleft")<CR>
    vmap <silent> <LocalLeader>sk :call RAction("topleft", "v")<CR>
    nmap <silent> <LocalLeader>sm :call RAction("summary")<CR>
    vmap <silent> <LocalLeader>sm :call RAction("summary", "v")<CR>
    nmap <silent> <LocalLeader>sc :call RAction("class")<CR>
    vmap <silent> <LocalLeader>sc :call RAction("class", "v")<CR>
    nmap <silent> <LocalLeader>sp :call RAction("typeof")<CR>
    vmap <silent> <LocalLeader>sp :call RAction("typeof", "v")<CR>
    nmap <silent> <LocalLeader>sn :call RAction("names")<CR>
    vmap <silent> <LocalLeader>sn :call RAction("names", "v")<CR>
    nmap <silent> <LocalLeader>sb :call RAction("dim")<CR>
    vmap <silent> <LocalLeader>sb :call RAction("dim", "v")<CR>
    nmap <silent> <LocalLeader>si :call RAction("unique")<CR>
    vmap <silent> <LocalLeader>si :call RAction("unique", "v")<CR>
    nmap <silent> <LocalLeader>sr :RSend library("colorout")<CR>
    nmap <LocalLeader>sw :RSend 
    "nmap <LocalLeader>sk :<C-U><C-R>=printf("RSend %s[1:5, 1:5]", expand("<cword>"))<CR><CR>

    " some nice keybindding, D = cursor down one line when finished the code
    " localleader+rv = view data, +rg = plot(graphic), +rs = summary, all without sending lines to R buffer, very useful
    " Other useful features like Rformat and R RBuildTags aren’t covered here, see Nvim-R for more info.

    " R output is highlighted with current colorscheme
    " let g:rout_follow_colorscheme = 1

    " R commands in R output are highlighted
    " let g:Rout_more_colors = 1

"if has('mac')
        "let g:python3_host_prog = '/usr/local/bin/python3'
    "endif

    let uname = substitute(system('uname -n'), '\n', '', '')
    if uname == "Machome.local"
            let g:python3_host_prog = '/usr/local/bin/python3'
        elseif uname == 'Macbook.local'
            let g:python3_host_prog = '/usr/local/bin/python3'
        elseif uname == 'ubuntuinPVE'
            let g:python3_host_prog = '/usr/bin/python3'
        elseif uname == 'tpm2-WD12.example.com'
            let g:python3_host_prog = '/home/data/vip24/miniconda3/bin/python3'
        elseif uname == 'ubuntu-home'
            let g:python3_host_prog = '/home/zhihuai1982/miniconda3/bin/python3'
        endif

Plug 'honza/vim-snippets'  " snippets repository

Plug 'chrisbra/csv.vim', {'for': ['r','rmarkdown']}    " for viewing data directly in vim R (Nvim-R)

"Plug 'vim-scripts/argtextobj.vim'

Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1

Plug 'sjl/gundo.vim'
    let g:gundo_prefer_python3 = 1
    nnoremap <leader>u :GundoToggle<CR><CR>

Plug 'voldikss/vim-floaterm'
    " Set floaterm window background to gray once the cursor moves out from it
    hi FloatermNC guibg=gray

    nnoremap   <silent>   <leader>tw    :FloatermNew<CR>
    tnoremap   <silent>   <leader>tw    <C-\><C-n>:FloatermNew<CR>
    nnoremap   <silent>   <leader>tp    :FloatermPrev<CR>
    tnoremap   <silent>   <leader>tp    <C-\><C-n>:FloatermPrev<CR>
    nnoremap   <silent>   <leader>tn    :FloatermNext<CR>
    tnoremap   <silent>   <leader>tn    <C-\><C-n>:FloatermNext<CR>
    nnoremap   <silent>   <leader>tg   :FloatermToggle<CR>
    tnoremap   <silent>   <leader>tg   <C-\><C-n>:FloatermToggle<CR>
    nnoremap   <silent>   <leader>tk    :FloatermKill<CR>
    tnoremap   <silent>   <leader>tk    <C-\><C-n>:FloatermKill<CR>
    nnoremap   <silent>   <leader>ta    :FloatermNew ranger<CR>
    tnoremap   <silent>   <leader>ta    <C-\><C-n>:FloatermNew ranger<CR>

Plug 'preservim/tagbar'
    nnoremap <leader>tb :TagbarToggle<CR>

    "for more language support
    "https://github.com/preservim/tagbar/wiki

    let g:tagbar_type_r = {
        \ 'ctagstype' : 'r',
        \ 'kinds'     : [
            \ 'f:Functions',
            \ 'g:GlobalVariables',
            \ 'v:FunctionVariables',
        \ ]
    \ }

    let g:tagbar_type_rmd = {
            \   'ctagstype':'rmd'
            \ , 'kinds':['h:header', 'c:chunk', 'f:function', 'v:variable']
            \ , 'sro':'&&&'
            \ , 'kind2scope':{'h':'header', 'c':'chunk'}
            \ , 'sort':0
            \ , 'ctagsbin':'~/.dotfiles/rmdtags.py'
            \ , 'ctagsargs': ''
            \ }

    let g:tagbar_type_markdown = {
        \ 'ctagstype': 'markdown',
        \ 'ctagsbin' : '~/.dotfiles/markdown2ctags.py',
        \ 'ctagsargs' : '-f - --sort=yes',
        \ 'kinds' : [
            \ 's:sections',
            \ 'i:images'
        \ ],
        \ 'sro' : '|',
        \ 'kind2scope' : {
            \ 's' : 'section',
        \ },
        \ 'sort': 0,
    \ }

"Plug 'ferrine/md-img-paste.vim'
    "autocmd FileType html,markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
    "let g:mdip_imgdir = '.'
    "let g:mdip_imgname = 'image'

" Use release branch (recommend)

Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " fix the most annoying bug that coc has
    "silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
    let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-actions',
    \ 'coc-pairs',
    \ 'coc-highlight',
    \ 'coc-diagnostic',
    \ 'coc-explorer',
    \ 'coc-git',
    \ 'coc-json',
    \ 'coc-tsserver',
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
    " Use <c-space> to trigger completion.
    " Use <c-u> to trigger completion.
    inoremap <silent><expr> <c-u> coc#refresh()

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> g[ <Plug>(coc-diagnostic-prev)
    nmap <silent> g] <Plug>(coc-diagnostic-next)

    " Open up coc-commands
    nnoremap <c-c> :CocCommand<CR>
    " Text Objects
    xmap kf <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap kf <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use K to show documentation in preview window.
    nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>

    function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
    endfunction

    " Useful commands
    nnoremap <silent> <space>y :<C-u>CocList --normal yank<cr>

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " coc-translator
    nmap <leader>vv <Plug>(coc-translator-e)
    vmap <leader>vv <Plug>(coc-translator-ev)

    "Remap for do codeAction of selected region
    "function! s:cocActionsOpenFromSelected(type) abort
    "execute 'CocCommand actions.open ' . a:type
    "endfunction
    "xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
    "nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

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
    xmap <leader>af  <Plug>(coc-format-selected)
    nmap <leader>af  <Plug>(coc-format)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)


Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle'}
    "<leader>tm to start 
    "h table-mode

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
    let g:Illuminate_delay = 250
    let g:Illuminate_highlightUnderCursor = 0
    "hi illuminatedWord cterm=undercurl gui=undercurl
    hi link illuminatedWord Visual

    
Plug 'mg979/vim-visual-multi'
    let g:VM_theme             = 'iceblue'
    "let g:VM_default_mappings = 0
    let g:VM_show_warnings = 0
    let g:VM_mouse_mappings   = 1
    let g:VM_maps = {}
    let g:VM_maps["Undo"]     = 'u'
    let g:VM_maps["Redo"]     = '<C-r>'
    "let g:VM_leader = '\'
    "let g:VM_custom_motions             = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
    "let g:VM_maps['i']                  = 'k'
    "let g:VM_maps['I']                  = 'K'
    "let g:VM_maps['Find Under']         = '<C-k>'
    "let g:VM_maps['Find Subword Under'] = '<C-k>'
    "let g:VM_maps['Find Next']          = ''
    "let g:VM_maps['Find Prev']          = ''
    "let g:VM_maps['Skip Region']        = '<c-n>'
    "let g:VM_maps['Remove Region']      = 'q'
    "let g:VM_maps["undo"]               = 'l'
    "let g:VM_maps["Redo"]               = '<C-r>'

Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp

Plug 'MattesGroeger/vim-bookmarks'
    let g:bookmark_no_default_key_mappings = 1
    nmap <leader>mt <Plug>BookmarkToggle
    nmap <leader>ma <Plug>BookmarkAnnotate
    nmap <leader>ml <Plug>BookmarkShowAll
    nmap <leader>mi <Plug>BookmarkNext
    nmap <leader>mn <Plug>BookmarkPrev
    nmap <leader>mC <Plug>BookmarkClear
    nmap <leader>mX <Plug>BookmarkClearAll
    nmap <leader>mu <Plug>BookmarkMoveUp
    nmap <leader>me <Plug>BookmarkMoveDown
    nmap <Leader>mg <Plug>BookmarkMoveToLine
    let g:bookmark_auto_save = 1
    let g:bookmark_highlight_lines = 1
    let g:bookmark_center = 1
    let g:bookmark_auto_close = 1
    "let g:bookmark_location_list = 1

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    " Start the preview :MarkdownPreview
    " Stop the preview" :MarkdownPreviewStop


Plug 'jalvesaq/zotcite'
    if has('mac')
        Plug 'jalvesaq/zotcite'
        "type @ then part of name of author then c+x c+o
        "source the zshrc for newly added zotero reference
    elseif has('unix')
    endif

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


     "l is for language server protocol
    "let g:which_key_map.l = {
        "\ 'name' : '+lsp' ,
        "\ '.' : [':CocConfig'                          , 'config'],
        "\ ';' : ['<Plug>(coc-refactor)'                , 'refactor'],
        "\ 'a' : ['<Plug>(coc-codeaction)'              , 'line action'],
        "\ 'A' : ['<Plug>(coc-codeaction-selected)'     , 'selected action'],
        "\ 'b' : [':CocNext'                            , 'next action'],
        "\ 'B' : [':CocPrev'                            , 'prev action'],
        "\ 'c' : [':CocList commands'                   , 'commands'],
        "\ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
        "\ 'D' : ['<Plug>(coc-declaration)'             , 'declaration'],
        "\ 'e' : [':CocList extensions'                 , 'extensions'],
        "\ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
        "\ 'F' : ['<Plug>(coc-format)'                  , 'format'],
        "\ 'h' : ['<Plug>(coc-float-hide)'              , 'hide'],
        "\ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
        "\ 'I' : [':CocList diagnostics'                , 'diagnostics'],
        "\ 'j' : ['<Plug>(coc-float-jump)'              , 'float jump'],
        "\ 'l' : ['<Plug>(coc-codelens-action)'         , 'code lens'],
        "\ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
        "\ 'N' : ['<Plug>(coc-diagnostic-next-error)'   , 'next error'],
        "\ 'o' : ['<Plug>(coc-openlink)'                , 'open link'],
        "\ 'O' : [':CocList outline'                    , 'outline'],
        "\ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
        "\ 'P' : ['<Plug>(coc-diagnostic-prev-error)'   , 'prev error'],
        "\ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
        "\ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
        "\ 'R' : ['<Plug>(coc-references)'              , 'references'],
        "\ 's' : [':CocList -I symbols'                 , 'references'],
        "\ 'S' : [':CocList snippets'                   , 'snippets'],
        "\ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
        "\ 'u' : [':CocListResume'                      , 'resume list'],
        "\ 'U' : [':CocUpdate'                          , 'update CoC'],
        "\ 'v' : [':Vista!!'                            , 'tag viewer'],
        "\ 'z' : [':CocDisable'                         , 'disable CoC'],
        "\ 'Z' : [':CocEnable'                          , 'enable CoC'],
        "\ }

call plug#end()


"augroup qs_colors
  "autocmd!
  "autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  "autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
"augroup END

colorscheme gruvbox
"set background=dark    " setting dark mode
" copy to system clipboard

vnoremap y "+y

" ============================ theme and status line ============================


" set mark column color 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" status line
"set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2   " Always show the status line - use 2 lines for the status bar

" ============================ specific file type ===========================

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai

" ============================ key map ============================
" 折叠后移动快捷键修改
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented

"nnoremap <leader>g :Goyo<CR>

"定义以下快捷键，用于快速编辑和重载vimrc配置文件：
"nnoremap <leader>ev :vsp $MYVIMRC<CR>

" jk 替换 Esc
"inoremap jk <Esc>
set t_BE=

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" save
cmap w!! w !sudo tee >/dev/null %

"改变光标模式

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR ="REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)


"nnoremap ; :
"vnoremap ; :
"nnoremap ' `
"nnoremap ` '

nnoremap H <c-w>h
nnoremap L <c-w>l
nnoremap K <c-w>k
nnoremap M <c-w>j

autocmd FileType markdown,rmd hi link markdownError NONE

noremap <leader>tl :tabe<CR>:-tabmove<CR>:term lazygit<CR>
noremap <leader>tr :tabe<CR>:-tabmove<CR>:term ranger<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap <leader>sb :set splitbelow<CR>:split<CR>
noremap <leader>sr :w<CR>:set splitright<CR>:vsplit<CR>:Startify<CR>
" Place the two screens up and down
noremap <leader>sh <C-w>t<C-w>K
" Place the two screens side by side
noremap <leader>sv <C-w>t<C-w>H

" find and replace
"noremap fr :%s//g<left><left>
nnoremap <silent> <leader>ar V:s/, /,\r/g<CR>:noh<CR>
"参数换行
vnoremap <silent> <leader>ar :s/, /,\r/g<CR>gv=

"nnoremap <leader>v :exe ':silent !open -a /Applications/Google\ Chrome.app %'<CR>

" Press ` to change case (instead of ~)
noremap ` ~

noremap <silent><tab>m :tabnew<cr>
noremap <silent><tab>e :tabclose<cr>
noremap <silent><tab>n :tabn<cr>
noremap <silent><tab>p :tabp<cr>
"noremap <silent><leader>t :tabnew<cr>
"noremap <silent><leader>g :tabclose<cr>
noremap <silent><leader>1 :tabn 1<cr>
noremap <silent><leader>2 :tabn 2<cr>
noremap <silent><leader>3 :tabn 3<cr>
noremap <silent><leader>4 :tabn 4<cr>
noremap <silent><leader>5 :tabn 5<cr>
noremap <silent><leader>6 :tabn 6<cr>
noremap <silent><leader>7 :tabn 7<cr>
noremap <silent><leader>8 :tabn 8<cr>
noremap <silent><leader>9 :tabn 9<cr>
noremap <silent><leader>0 :tabn 10<cr>
let g:which_key_map.1 = 'which_key_ignore'
let g:which_key_map.2 = 'which_key_ignore'
let g:which_key_map.3 = 'which_key_ignore'
let g:which_key_map.4 = 'which_key_ignore'
let g:which_key_map.5 = 'which_key_ignore'
let g:which_key_map.6 = 'which_key_ignore'
let g:which_key_map.7 = 'which_key_ignore'
let g:which_key_map.8 = 'which_key_ignore'
let g:which_key_map.9 = 'which_key_ignore'
let g:which_key_map.0 = 'which_key_ignore'
noremap <silent><s-tab> :tabnext<CR>
inoremap <silent><s-tab> <ESC>:tabnext<CR>

" background transpant
hi Normal guibg=NONE ctermbg=NONE

noremap <leader>l <c-w>l?^><CR>
