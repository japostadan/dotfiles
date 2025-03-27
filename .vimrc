"
"
"	   ▐▌ ▄▄▄     ■  ▗▞▀▀▘▄ █ ▗▞▀▚▖ ▄▄▄ 
"	   ▐▌█   █ ▗▄▟▙▄▖▐▌   ▄ █ ▐▛▀▀▘▀▄▄  
"	▗▞▀▜▌▀▄▄▄▀   ▐▌  ▐▛▀▘ █ █ ▝▚▄▄▖▄▄▄▀ 
"	▝▚▄▟▌        ▐▌  ▐▌   █ █           
"	   	          ▐▌                     
"	 	                                   japostad@student.42barcelona.com
                                    


if has("eval")                               " vim-tiny lacks 'eval'
  let skip_defaults_vim = 1
endif

set nocompatible
let mapleader=","


"############################ Syntax ###################################
" here because plugins and stuff need it

if has("syntax")
  syntax enable
endif

"#######################################################################


"####################### Vi Compatible (~/.exrc) #######################

set number relativenumber	" deactivate line numbers
set autoindent 				" automatically indent new lines
set autoread				" Reload files changed outside vim
set mouse=a					" Enable mouse in vim
set noignorecase			" use case when searching
set showmode				" show command and insert mode
set t_vb=					" disable visual bell (also disable in .inputrc)
set smartindent
set ts=4
set sw=4
set smarttab
set icon
set ttyfast					" faster scrolling
filetype plugin on			" allow sensing the filetype
syntax on
set wildmenu				" better command-line completion

map Y y$					
" make Y consistent with D and C (yank til end)

"#######################################################################


"####################### Dissable Swap files ###########################

set nobackup
set noswapfile
set nowritebackup

"#######################################################################

" Edit/Reload vimrc configuration file
nnoremap confe :e $HOME/.vimrc<CR>
nnoremap confr :source $HOME/.vimrc<CR>

"############################ Plugins ##################################

if filereadable(expand("~/.vim/autoload/plug.vim"))

  " github.com/junegunn/vim-plug

  call plug#begin('~/.local/share/vim/plugins')
  Plug 'zah/nim.vim'
  Plug 'conradirwin/vim-bracketed-paste'
  Plug 'morhetz/gruvbox'
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'rwxrob/vim-pandoc-syntax-simple'
  Plug 'dense-analysis/ale'
  call plug#end()

endif
"######################################################################

nmap <leader>2 :set paste<CR>i

" disable arrow keys (vi muscle memory)
" noremap <up> :echoerr "Umm, use k instead"<CR>
" noremap <down> :echoerr "Umm, use j instead"<CR>
" noremap <left> :echoerr "Umm, use h instead"<CR>
" noremap <right> :echoerr "Umm, use l instead"<CR>
" inoremap <up> <NOP>
" inoremap <down> <NOP>
" inoremap <left> <NOP>
" inoremap <right> <NOP>

" better use of arrow keys, number increment/decrement
" nnoremap <up> <C-a>
" nnoremap <down> <C-x>

" Better page down and page up
noremap <C-n> <C-d>
noremap <C-p> <C-b>
