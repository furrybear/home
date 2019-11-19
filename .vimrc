
" Width of a Tab is equal to 4 spaces
set tabstop=4
" Replace tab inputed with spaces, while the true Tab should be input with C-V<Tab>
set expandtab
" 
set smartindent
" Every indent is equal to 4 spaces
set shiftwidth=4
" Delete 4 spaces when delete intend with backspace key
set softtabstop=4 

" Line number
set nu

"
set backspace=indent,eol,start

"
syntax on

autocmd BufNewFile *.py 0r ~/.vim/templates/tmpl.py
autocmd BufNewFile *.sh 0r ~/.vim/templates/tmpl.sh
set pastetoggle=<F2>
"Write with admin priviledge. Vim will replace sudow with the later comamnd.
cnoreabbrev sudow w !sudo tee %
let mapleader = ","
nnoremap <leader>v <C-V>
