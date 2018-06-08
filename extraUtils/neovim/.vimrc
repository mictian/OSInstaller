
set nocompatible	" be iMproved, required
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'

" We could also add repositories with a ".git" extension
Plugin 'scrooloose/nerdtree.git'

" Vim Plugin to list, select and switch between buffers
" Plugin 'Buffergator'

" To find files like Sublime
Plugin 'kien/ctrlp.vim'

" Linter
Plugin 'scrooloose/syntastic'

" JavaScript esLinter
Plugin 'pmsorhaindo/syntastic-local-eslint.vim'

" Lean Status bar
Plugin 'bling/vim-airline'

" JavaScrtipt Syntax
Plugin 'jelera/vim-javascript-syntax'

" Extra JavaScript Syntax highlighter plus some extra features
Plugin 'pangloss/vim-javascript'

" Automatically close some characters
Plugin 'Raimondi/delimitMate'

" Basic Auto-Competition
Plugin 'Valloric/YouCompleteMe'

" Advanced JavaScript indentation plugin
Plugin 'marijnh/tern_for_vim'

" Global Searchers
Plugin 'mileszs/ack.vim'

" Enhance Node developing experience
Plugin 'moll/vim-node'

" HTML5 Competition
Plugin 'othree/html5.vim'

" HTML5 Syntax highlighter
Plugin 'othree/html5-syntax.vim'

" Extra support for particular libraries
Plugin 'othree/javascript-libraries-syntax.vim'

" CSS Auto-Competition
Plugin 'hail2u/vim-css3-syntax'

" Multi-cursor
Plugin 'terryma/vim-multiple-cursors'

" Mustache and Handlebars syntax and shortcuts
Plugin 'mustache/vim-mustache-handlebars'

" Now we can turn our filetype functionality back on
filetype plugin indent on


" CUSTOMIZATION

"Show line numbers
set number

"Set tags file location. In this way it is searched in the current directory and looks up in the tree.
set tags=/home/mictian/NS/SCA/tags

" Not auto-generate backups
set nobackup
set nowritebackup

" set c-style indentation
set cindent
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert a tab character
set noexpandtab
" Disable the creation of swap files
set noswapfile
" Highlight Search results
set hlsearch
" Make Search NOT case sensitive
set ignorecase

" Set .hbs (handlebars) files to be treated as html
" au BufReadPost *.hbs set syntax=html

" Set a nice dark syntax
set t_Co=256
syntax on
set background=dark
colorschem distinguished

" Move tabs
map <C-h> gT
map <C-l> gt
map <C-j> :tabm -1<CR>
map <C-k> :tabm +1<CR>

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

" Status bar shows line, col, file, file-format, file-type:
set laststatus=2
set statusline=Ln\ %l\ Col\ %v\ %F\ (%{&ff},\ %Y)

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


" PLUGINS CUSTOMIZATIONS

" JavaScript libraries Syntax
let g:used_javascript_libs = 'jquery,underscore,underscore,backbone,prelude,angularjs,angularui,angularuirouter,react,flux,requirejs,sugar,jasmine,chai,handlebars'

" YCM
" These are the tweaks I apply to YCM's config, you don't need them but they
" might help.
" YCM gives you popups and splits by default that some people might not
" like, so these should tidy it up a bit for you.
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" Mustache & Handlebars
" enable abbreviations
let g:mustache_abbreviations = 1

" AirLine
" Appear at first
set laststatus=2

" Syntastic
" JavaScript Linter Command
"let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['javascript'],  'passive_filetypes': [] }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_checkers = ['eslint']



" Have Syntastic Use Closest .jshintrc / https://gist.github.com/ethagnawl/ed4bd3eba6389ffe9430
" Custom syntastic settings:
function s:find_jshintrc(dir)
	let l:found = globpath(a:dir, '.jshintrc')
	if filereadable(l:found)
		return l:found
	endif

	let l:parent = fnamemodify(a:dir, ':h')
	if l:parent != a:dir
		return s:find_jshintrc(l:parent)
	endif

	return "~/.jshintrc"
endfunction

function UpdateJsHintConf()
	let l:dir = expand('%:p:h')
	let l:jshintrc = s:find_jshintrc(l:dir)
	let g:syntastic_javascript_jshint_args = l:jshintrc
endfunction

au BufEnter * call UpdateJsHintConf()

" CtrlP
" Excluded folders
let g:ctrlp_custom_ignore = 'node_modules\|DeployDistribution\|LocalDistribution\|Backups'

" NERDTree
" IngoredFolders
let NERDTreeIgnore=['node_modules', 'DeployDistribution', 'LocalDistribution', 'Backups']
" Give a shortcut key to NERD Tree
map ,m :NERDTreeToggle<CR>
map ,n :NERDTreeFind<CR>
