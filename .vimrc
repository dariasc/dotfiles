set cin aw ai is ts=4 sw=4 nu noeb bg=dark ru cb=unnamedplus et
sy on
ino jk <esc> | ino kj <esc>
ino {<CR> {<CR>}<Esc>ko
no ; :
ca Hash w !cpp -dD -P -fpreprocessed \| tr -d '[:space:]' \| md5sum \| cut -c-6

call plug#begin()
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'tpope/vim-commentary'
call plug#end()

colorscheme habamax
hi Normal guibg=NONE ctermbg=NONE

