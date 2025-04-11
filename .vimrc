set nocompatible
set mouse=

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:polyglot_disabled = ['pascal', 'puppet']

call plug#begin()
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --go-completer' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'chaoren/vim-wordmotion'
Plug 'chrisbra/matchit'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'
Plug 'luochen1990/rainbow'
Plug 'matcatc/vim-asciidoc-folding'
Plug 'mileszs/ack.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'nathangrigg/vim-beancount'
Plug 'rodjek/vim-puppet'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'sirtaj/vim-openscad'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
call plug#end()

" install fonts-powerline on Debian or powerline-fonts on Fedora
" requires https://github.com/powerline/powerline/pull/1765 when using
" terminus in xfce4-terminal
let g:airline_powerline_fonts = 1

" better collors
set background=dark
colorscheme solarized
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

autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"

" https://www.reddit.com/r/vim/comments/slkfy0/adding_custom_handlers_for_gbrowse_command/
function! YourCustomHandler(opts)
    " return if it there's no gitlab substring in remote
    if a:opts.remote !~? 'gitlab'
        return
    endif

    let op = a:opts
    " Convert data from opts variable into a valid link

    " Remove protocol of remote (ssh://, http://, https://)
    let s:remote = substitute(a:opts.remote, '^.*//', '', '')
    " Remove git@ and replace : with / of remote (in case protocol was ssh)
    let s:remote = substitute(s:remote, 'git@', '', '')
    let s:remote = substitute(s:remote, ':', '\/', '')
    " Remove .git postfix from remote
    let s:remote = substitute(s:remote, '\.git$', '', '')
    return 'https://'. s:remote .'/blob/'. op.commit .'/'. op.path .'#L'. op.line1 .'-L'. op.line2
endfunction

let s:handlers = get(g:, 'fugitive_browse_handlers', [])
let g:fugitive_browse_handlers = add(s:handlers, 'YourCustomHandler')
