set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'Raimondi/delimitMate'
Plugin 'majutsushi/tagbar'
Plugin 'fatih/molokai'
Plugin 'kien/ctrlp.vim'

call vundle#end()            " required
filetype plugin indent on    " required

"Settings


set noerrorbells " No beeps
set number " Show line numbers
set backspace=indent,eol,start " Makes backspace key more powerful.
set showcmd " Show me what I'm typing
set showmode " Show current mode.
set noswapfile " Don't use swapfile
set nobackup " Don't create annoying backup files
set splitright " Split vertical windows right to the current windows
set splitbelow " Split horizontal windows below to the current windows
set encoding=utf-8 " Set default encoding to UTF-8
set autowrite " Automatically save before :next, :make etc.
set autoread " Automatically reread changed files without asking me anything
set laststatus=2
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats"
set incsearch " Shows the match while typing"
set hlsearch " Highlight found searches"
set ignorecase " Search case insensitive...
set smartcase " ... but not when search pattern contains upper case characters
set ttyfast
"Time out on key codes but not mappings.
"Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10
"Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

colorscheme molokai

"Go settings
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

set wildmenu
set wildmode=list:longest
set wildmode=list:full
set wildignore+=.hg,.git,.svn " Version control
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files
set wildignore+=*.DS_Store " OSX bullshit
set wildignore+=*.luac " Lua byte code
set wildignore+=migrations " Django migrations
set wildignore+=go/pkg " Go static files
set wildignore+=go/bin " Go bin files
set wildignore+=go/bin-vagrant " Go bin-vagrant files
set wildignore+=*.pyc " Python byte code
set wildignore+=*.orig " Merge resolution files
"Prettify json
com! JSONFormat %!python -m json.tool

"Plugin configs "
"----------------------------------------- "
""==================== CtrlP ====================
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_match_func = {'match' : 'matcher#cmatch'}
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_height = 10 " maxiumum height of match window
let g:ctrlp_switch_buffer = 'et' " jump to a file if it's open already
let g:ctrlp_mruf_max=450 " number of recently opened files
let g:ctrlp_max_files=0 " do not limit the number of searchable files
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
func! MyPrtMappings()
let g:ctrlp_prompt_mappings = {
\ 'AcceptSelection("e")': ['<c-t>'],
\ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
\ }
endfunc
func! MyCtrlPTag()
let g:ctrlp_prompt_mappings = {
\ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
\ 'AcceptSelection("t")': ['<c-t>'],
\ }
CtrlPBufTag
endfunc
let g:ctrlp_buffer_func = { 'exit': 'MyPrtMappings' }
com! MyCtrlPTag call MyCtrlPTag()
let g:ctrlp_buftag_types = {
\ 'go' : '--language-force=go --golang-types=ftv',
\ 'coffee' : '--language-force=coffee --coffee-types=cmfvf',
\ 'markdown' : '--language-force=markdown --markdown-types=hik',
\ 'objc' : '--language-force=objc --objc-types=mpci',
\ 'rc' : '--language-force=rust --rust-types=fTm'
\ }
"get me a list of files in the current dir))))

""==================== YouCompleteMe ====================
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1
""==================== ChooseWin ====================
nmap - <Plug>(choosewin)
""==================== DelimitMate ====================
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
""==================== Fugitive ====================
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
vnoremap <leader>gb :Gblame<CR>
""==================== Vim-go ====================
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gofmt"
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>t <Plug>(go-def-tab)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <Leader>d <Plug>(go-doc)
""==================== UltiSnips ====================
function! g:UltiSnips_Complete()
call UltiSnips#ExpandSnippetOrJump()
if g:ulti_expand_or_jump_res == 0
if pumvisible()
return "\<C-N>"
else
return "\<TAB>"
endif
endif
return "
endfunction
function! g:UltiSnips_Reverse()
call UltiSnips#JumpBackwards()
if g:ulti_jump_backwards_res == 0
return "\<C-P>"
endif
return "
endfunction
if !exists("g:UltiSnipsJumpForwardTrigger")
let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . "<C-R>=g:UltiSnips_Complete()<cr>"
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
" ==================== NerdTree ====================
" Open nerdtree in current dir, write our own custom function because
" NerdTreeToggle just sucks and doesn't work for buffers
function! g:NerdTreeFindToggle()
if nerdtree#isTreeOpen()
exec 'NERDTreeClose'
else
exec 'NERDTreeFind'
endif
endfunction
" For toggling
noremap <Leader>n :<C-u>call g:NerdTreeFindToggle()<cr>
" For refreshing current file and showing current dir
noremap <Leader>j :NERDTreeFind<cr>
" vim:ts=4:sw=4:et
