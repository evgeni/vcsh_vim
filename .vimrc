set nocompatible
set mouse=

call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-slash'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'vim-syntastic/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
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
let g:gitgutter_sign_column_always = 1
" quicker updates
set updatetime=500

" no need to do syntax checks on exit
let g:syntastic_check_on_wq = 0

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
