"both are required for Vundle and should be at the top of the .vimrc file
set nocompatible 
filetype off 

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
"keep Plugin commands between vundle#begin/end
call vundle#begin()

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" navigate between vim and tmux splits
Plugin 'christoomey/vim-tmux-navigator'

"autocomplete package (install ncurses5-compat-libs with a aur package manager -
"otherwise ymcd server will not start as libtinfo.so.5 is missing)
"also see the below code for setting the ycm conf file
Plugin 'Valloric/YouCompleteMe'

"syntax checking
Plugin 'w0rp/ale'

"automate correcting errors(had to install with pip)
Plugin 'tell-k/vim-autopep8'

" produce templates/snippets for definitions, functions etc
Plugin 'SirVer/ultisnips'
" snippets are separate from the engine. Add the following if you want them:
" see below for trigger configuration
Plugin 'honza/vim-snippets'

"compile c in quickfix window as well as python
Plugin 'skywind3000/asyncrun.vim'

"file tree
Plugin 'scrooloose/nerdtree'

"search files with the ctrl-p program
Plugin 'ctrlpvim/ctrlp.vim'

"surround text with parentheses, brackets, quotes, tags etc
Plugin 'tpope/vim-surround'

"vim-airline (powerline now deprecated)
Plugin 'vim-airline/vim-airline'

"icons for nerdtree and ctrlp
Plugin 'ryanoasis/vim-devicons'

"All of your Plugins must be added before the following line:
call vundle#end()		" required
filetype plugin indent on	" required

" disable beeps
set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

syntax on
syntax enable

"add this line to .vimrc after loading YCM; this sets the default location for
"ycm_extra_conf.py (needed for .c and .cpp extensions)
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'

" remapping: nmap(normal mode) vmap(visual) imap(insert mode).
" the 'nore' is to prevent looping

" copy and paste shortcuts for system clipboard
" vnoremap <C-y> "+y (commented because the *y line is uncommented) 
map <C-p> "*P
" for copying to both the clipboard and primary selection (to paste into st from vim this is required)
vnoremap <C-y> "*y :let @+=@*<CR>

"Enable Folding
set nofoldenable

" show line numbers
set nu 

" split navigations in :sp
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"open nerdtree with the following remapping: \(leader)+nt
nnoremap <silent> <Leader>nt :NERDTreeToggle<CR>
"enable icons in nerdtree as well as utf-8 support in general
set encoding=UTF-8
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
" let g:airline_powerline_fonts = 1 
" set guifont=Droid\ Sans\ Mono\ Nerd\ Font\ Complete\ Mono\ 11 

"ctrlp settings (remapped to Ctrl-f because Ctrl-p is now for paste) 
"ctrl p buffer settings {tab number}gt
"nnoremap <silent> <C-f> :CtrlP<CR>
let g:ctrlp_map = '<c-f>'
let g:ctrlp_switch_buffer = 'Et' " If already opened jump to it
" let g:ctrlp_show_hidden = 1 "show hidden files and directories
set wildignore+=*.a,*.o,*.out "ignore binaries
set wildignore+=*.bmp,,*.gif,*.ico,*.jpg,*.png,*.pdf "ignore images

"use urlview to choose and open a url
:noremap <leader>u :w<Home>silent <End> !urlview<CR>

"python stuff
au BufNewFile,BufRead *.py
	\ set tabstop=4   |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=120 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix 
let python_highlight_all = 1

"ALE
"ale - stop having the linter run continuously, only after you save:
let g:ale_lint_on_text_changed = 'never'
"ale - stop having the linter show errors upon opening a file:
let g:ale_lint_on_enter = 0

"disable highlighting with ale
let g:ale_set_highlights = 0

" highlight ALEWarning ctermbg=DarkMagenta 
let g:airline#extensions#ale#enabled = 1 "integrate with the airline-bar
let g:ale_set_loclist = 0
let g:ale_open_list = 1
let g:ale_set_quickfix = 1

"map autopep8 to \8
au FileType python noremap <Leader>8 :call Autopep8()<CR>
let g:autopep8_disable_show_diff=1 " disable the pop up window
let g:autopep8_max_line_length=120

"trigger config. for snippets(ultisnips)
let g:UltiSnipsUsePythonVersion = 3
" let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<C-x>"
let g:UltiSnipsListSnippets="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<CR>

" ASYNCRUN
"asyncrun - run a python script map to <F5>
:noremap <F5> :AsyncRun -raw python %
let $PYTHONUNBUFFERED = 1
"open the quickfix window automatically when triggering asyncrun
augroup MyGroup
	autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END
"<F10> to show/hide the quickfix window
:noremap <F10> : call asyncrun#quickfix_toggle(8)<cr> 

"flagging unnecessary Whitespace
highlight BadWhiteSpace ctermbg=yellow guibg=yellow
:autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.go match BadWhiteSpace /\s\+$/
