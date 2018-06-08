
set nocompatible  " be iMproved, required
filetype off
filetype plugin on


let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))


"*****************************************************************************
" PLUGINS
"*****************************************************************************

" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'

"  Navigation Sidebar
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Comment lines with gc (https://github.com/tpope/vim-commentary)
Plug 'tpope/vim-commentary'

" Git commands from VIM with :Git [args]
Plug 'tpope/vim-fugitive'

" Shows a git diff in the gutter (extra column next to numbers)
Plug 'airblade/vim-gitgutter'

" Lean Status bar
Plug 'bling/vim-airline'
" Status bar theme (https://github.com/vim-airline/vim-airline/wiki/Screenshots)
Plug 'vim-airline/vim-airline-themes'

" Automatically close some characters
Plug 'Raimondi/delimitMate'

" Linter
Plug 'vim-syntastic/syntastic'
" JavaScript esLinter
" Plug 'pmsorhaindo/syntastic-local-eslint.vim'

" vim-prettier Code formatter
" https://github.com/heavenshell/vim-prettier 
" https://github.com/prettier/prettier/blob/master/docs/vim.md
Plug 'prettier/vim-prettier', {
    \ 'do': 'npm install',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss'] }

" Multi-cursor
Plug 'terryma/vim-multiple-cursors'

" INVALIDATES gt and gT to move between tabs!
"Plug 'vim-scripts/CSApprox'

" Server Auto-Competition
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }

" Client Auto-Competition
Plug 'Valloric/YouCompleteMe', {'do': './install.py --js-completer'}

" Search functionality
Plug 'vim-scripts/grep.vim'

if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

"" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" Snippets engine
Plug 'SirVer/ultisnips'
" Snippets collection
Plug 'honza/vim-snippets'


" Syntax and indentation for many languages
Plug 'sheerun/vim-polyglot'

" JavaScrtipt Syntax
Plug 'jelera/vim-javascript-syntax'

" Extra JavaScript Syntax highlighter plus some extra features
Plug 'pangloss/vim-javascript'

" Enhance Node developing experience (gf over require files to navigate to it)
Plug 'moll/vim-node'

" HTML5 Competition
Plug 'othree/html5.vim'

" HTML5 Syntax highlighter
Plug 'othree/html5-syntax.vim'

" Extra support for particular libraries
Plug 'othree/javascript-libraries-syntax.vim'

" CSS Auto-Competition
Plug 'hail2u/vim-css3-syntax'

" Mustache and Handlebars syntax and shortcuts
Plug 'mustache/vim-mustache-handlebars'

" Color
Plug 'tomasr/molokai'

" Code evalution
Plug 'metakirby5/codi.vim'

" Run test file
Plug 'janko-m/vim-test'
" Follow up: https://github.com/janko-m/vim-test/issues/219

" Zim-wiki replacement using VIM :D
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

"" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

call plug#end()


" Now we can turn our filetype functionality back on
filetype plugin indent on


"*****************************************************************************
" CUSTOMIZATION
"*****************************************************************************

"**************************************
"" Basic Setup
"**************************************

"" Encoding
"------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

"" Miscellaneous
"------------------------------------------
" Fix backspace indent
set backspace=indent,eol,start
" set c-style indentation
set cindent
" Enable hidden buffers
set hidden
set fileformats=unix,dos,mac

"" Tabs.  (May be overriten by autocmd rules)
"------------------------------------------
" show existing tab with 4 spaces width
set tabstop=4
set softtabstop=0
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert a tab character
set noexpandtab
" set expandtab

"" Directories for swp files
"------------------------------------------
" Not auto-generate backups
set nobackup
set nowritebackup
" Disable the creation of swap files
set noswapfile

"" Searching
"------------------------------------------
" Highlight Search results
set hlsearch
set incsearch
" Make Search NOT case sensitive
set ignorecase
set smartcase

" Enable spell checker
"------------------------------------------
set spelllang=en_us
set spell

" Terminal
"------------------------------------------
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

"**************************************
"" Visual Settings
"**************************************

" Theme (Set a nice dark syntax)
"------------------------------------------
set t_Co=256
syntax on
set background=dark
"colorscheme distinguished
colorscheme molokai


"" Miscellaneous
"------------------------------------------
" Show line numbers
set number
" enable line and column display
set ruler
" hide default buffers menu
let no_buffers_menu=1
" Disable the blinking cursor.
set gcr=a:blinkon0
" minimum nr. of lines above and below cursor"
set scrolloff=3
"" Use modeline overrides
set modeline
set modelines=10
" let Vim set the title of the window 
set title
" old title, restored when exiting
set titleold="Terminal"
" string to use for the Vim window title
set titlestring=%F

" Disable visualbell (make loud dings)
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif


" Status Bar
"------------------------------------------
" Status bar shows line, col, file, file-format, file-type:
set laststatus=2
set statusline=Ln\ %l\ Col\ %v\ %F\ (%{&ff},\ %Y)
"set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif


"**************************************
"" Key Mapping
"**************************************

" Map leader to ,
let mapleader=','

" Copy/Paste/Cut
"------------------------------------------
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Copy to clipboard (uncomment if desire)
"vnoremap  <leader>y  "+y
"nnoremap  <leader>Y  "+yg_
"nnoremap  <leader>y  "+y
"nnoremap  <leader>yy  "+yy

" Paste from clipboard (uncomment if desire)
"nnoremap <leader>p "+p
"nnoremap <leader>P "+P
"vnoremap <leader>p "+p
"vnoremap <leader>P "+P


"" Split
"------------------------------------------
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>



" Tabs & Buffers (Move)
"------------------------------------------
map <C-h> gT
map <C-l> gt
map <C-j> :tabm -1<CR>
map <C-k> :tabm +1<CR>
nnoremap <silent> <S-t> :tabnew<CR>

"" Buffer navigation
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>


"" Search / Open files
"------------------------------------------
"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>


"" Terminal/Shell
"------------------------------------------
" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>

"" Miscellaneous
"------------------------------------------
"" no one is really happy until you have this shortcuts
" This allows to use :W! instead of :w!, for example
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" Remove Trailing white-spaces on Save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun


" autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Save all
" nmap <Leader>s :wa<CR>
nmap <C-s> :w<CR>
nmap <C-S-S> :wa<CR>


" Home key alternates between start of text and column zero.
function ExtendedHome()
  let column = col('.')
  normal! ^
  if column == col('.')
  normal! 0
  endif
endfunction

noremap <silent> <Home> :call ExtendedHome()<CR>
inoremap <silent> <Home> <C-O>:call ExtendedHome()<CR>


" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
  function! MyTabLine()
    let s = ''
    let wn = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      let s .= ' '
      let wn = tabpagewinnr(i,'$')

      let s .= '%#TabNum#'
      let s .= i
      " let s .= '%*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')
      if buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif
      else
        let file = fnamemodify(file, ':p:t')
      endif
      if file == ''
        let file = '[No Name]'
      endif
      let s .= ' ' . file . ' '
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
  endfunction
  set stal=2
  set tabline=%!MyTabLine()
  set showtabline=1
  highlight link TabNum Special
endif

"" Include user's local vim config
if filereadable(expand("~/.config/nvim/local_init.vim"))
  source ~/.config/nvim/local_init.vim
endif


"*****************************************************************************
" PLUGINS CUSTOMIZATIONS
"*****************************************************************************

" NERDTree
"------------------------------------------
" IngoredFolders
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
" Give a shortcut key to NERD Tree
map ,m :NERDTreeToggle<CR>
map ,n :NERDTreeFind<CR>

let g:NERDTreeChDirMode=2
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
"let g:NERDTreeShowBookmarks=1
let g:NERDTreeWinSize=50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
let NERDTreeShowHidden=1


" vim-airline
"------------------------------------------
"let g:airline_theme = 'powerlineish'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif


" Syntastic
"------------------------------------------
" JavaScript Linter Command
"let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['javascript'],  'passive_filetypes': [] }

let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol='✗'
let g:syntastic_style_warning_symbol='⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors=1
let g:syntastic_javascript_checkers=['eslint']
" Assume a local installation of ESLint
let g:syntastic_javascript_eslint_exec= $PWD . '/node_modules/.bin/eslint'
"let g:syntastic_javascript_eslint_exec = '$(npm bin)/eslint'
"let g:syntastic_javascript_eslint_exec = '[ -f $(npm bin)/eslint ] && $(npm bin)/eslint || eslint'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Have Syntastic Use Closest .jshintrc / https://gist.github.com/ethagnawl/ed4bd3eba6389ffe9430
" Custom syntastic settings:
"function s:find_jshintrc(dir)
" let l:found = globpath(a:dir, '.jshintrc')
" if filereadable(l:found)
"   return l:found
" endif
"
" let l:parent = fnamemodify(a:dir, ':h')
" if l:parent != a:dir
"   return s:find_jshintrc(l:parent)
" endif
"
" return "~/.jshintrc"
"endfunction
"
"function UpdateJsHintConf()
" let l:dir = expand('%:p:h')
" let l:jshintrc = s:find_jshintrc(l:dir)
" let g:syntastic_javascript_jshint_args = l:jshintrc
"endfunction
"
"au BufEnter * call UpdateJsHintConf()



" vim-fugitive (Git)
"------------------------------------------
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>


" grep.vim
"------------------------------------------
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'


"" fzf.vim
"------------------------------------------
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path '*/node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
"if executable('ag')
"  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
"  set grepprg=ag\ --nogroup\ --nocolor
"endif

" ripgrep
"if executable('rg')
"  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
"  set grepprg=rg\ --vimgrep
"  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
"endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>


" JavaScript libraries Syntax (javascript-libraries-syntax.vim)
"------------------------------------------
let g:used_javascript_libs = 'jquery,underscore,backbone,prelude,angularjs,angularui,angularuirouter,flux,requirejs,sugar,jasmine,chai,handlebars,react,ramda'


" YCM
"------------------------------------------
" These are the tweaks I apply to YCM's config, you don't need them but they
" might help.
" YCM gives you popups and splits by default that some people might not
" like, so these should tidy it up a bit for you.
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview


" Vim-Session (session management)
"------------------------------------------
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1


" Mustache & Handlebars
"------------------------------------------
" enable abbreviations
let g:mustache_abbreviations = 1


" Raimondi/delimitMate
"------------------------------------------
" Automatically insert and enter and a tab when opening a brackets {
" Source: http://stackoverflow.com/questions/4477031/vim-auto-indent-with-newline
let delimitMate_expand_cr=1


" jelera/vim-javascript-syntax
"------------------------------------------
let g:javascript_enable_domhtmlcss = 1


" SirVer/ultisnips & honza/vim-snippets (snippets)
"------------------------------------------

" from: https://github.com/SirVer/ultisnips/issues/376
let g:UltiSnipsExpandTrigger = "<nop>"
inoremap <expr> <CR> pumvisible() ? "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" : "\<CR>"

" let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" prettier/vim-prettier
"------------------------------------------
" Automatically format on save
autocmd BufWritePost *.js,*.jsx,*.css,*.scss,*.less PrettierAsync