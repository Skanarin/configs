" ~/.vimrc

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

runtime! plugin/sensible.vim

call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" auto comp
Plug 'vim-scripts/AutoComplPop'

" Plugin font
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/vim-color-forest-night'

Plug 'vim-airline/vim-airline'

" Initialize plugin system
call plug#end()

colorscheme onedark

set encoding=utf-8 fileencodings=
syntax on

set mouse=a

set cmdheight=1

" search help
set ignorecase
set smartcase
set hlsearch
set incsearch
set noswapfile

" space help
:set list
:set listchars:eol:$,trail:.

" tab help
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" menu
set wildmenu
set wildmode=list:longest,full

" linebreak
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

let &t_SI = "\<esc>[6 q"  " solid I-beam in insert mode
let &t_SR = "\<esc>[4 q"  " solid underline in replace mode
let &t_EI = "\<esc>[2 q"  " default cursor solid block otherwise

set number
set cc=80

" per .git vim configs
" just `git config vim.settings "expandtab sw=4 sts=4"` in a git repository
" change syntax settings for this repository
let git_settings = system("git config --get vim.settings")
if strlen(git_settings)
	exe "set" git_settings
endif

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-y>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-tab> <c-n>
