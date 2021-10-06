set nocompatible
set mouse=

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'
Plug 'luochen1990/rainbow'
Plug 'mileszs/ack.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'nathangrigg/vim-beancount'
call plug#end()

" install fonts-powerline on Debian or powerline-fonts on Fedora
" requires https://github.com/powerline/powerline/pull/1765 when using
" terminus in xfce4-terminal
let g:airline_powerline_fonts = 1

" better collors
colorscheme solarized
set background=dark
let g:airline_theme='solarized'

" always show gitgutter column, so it does not jump
set signcolumn=yes
" quicker updates
set updatetime=500

" no need to do syntax checks on exit
let g:syntastic_check_on_wq = 0

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Don't do editorconfig for fugituve
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

autocmd FileType markdown setlocal spell
