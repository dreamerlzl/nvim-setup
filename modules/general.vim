" for general neovim setup
" no plugin config involved

" {{{ setting

set encoding=UTF-8
" left bar toggled by lsp
set number
set signcolumn=number
set clipboard+=unnamedplus
set cursorline
set smartindent
set softtabstop=0 expandtab 
set shiftwidth=2 smarttab
set splitbelow
set splitright
set guifont=MesloLGL\ Nerd\ Font\ Mono:h16

set autochdir

" for buffering unsaved files
set hidden

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.get(0)

" }}}

" {{{ add mapping

:tnoremap <Esc> <C-\><C-n>
:inoremap jj <Esc>
" for switching tabs
nnoremap J gT
nnoremap K gt
" for delete without copy
vnoremap d "_d
" yank to/paste from system clipboard
vnoremap p "+p
vnoremap x "+x
vnoremap y "+y

" for tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" }}}

" {{{ key remap

nnoremap <SPACE> <Nop>
let mapleader = " "
let g:netrw_winsize = 25
let g:loaded_matchparen = 1
let g:colorscheme_primary_disable_italic = 1
let g:rainbow_active = 1

" }}}

" {{{ misc 


" for prog lang syntax highlight
syntax enable
filetype plugin indent on

if has('termguicolors')
  set termguicolors
endif

set background=light
colo primary
hi DiagnosticWarn ctermfg=3 guifg=#9D5214
hi DiagnosticHint ctermfg=7 guifg=#000000

"set background=dark
"colo onedark

hi signcolumn guibg=None
" hi cursorline guibg=#b9cbda
" hi cursorlinenr guibg=#b9cbda
hi LineNr guibg=None
hi GitGutterAdd guibg=None
hi GitGutterChange guibg=None
hi GitGutterDelete guibg=None
hi GitGutterChangeDelete guibg=None

" reverse selected highlight
highlight Visual cterm=reverse

nnoremap <C-s> :call ToggleSignColumn()<CR>
" Toggle signcolumn. Works on vim>=8.1 or NeoVim
function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=number
        let b:signcolumn_on=1
    endif
endfunction

lua << END

require("scrollbar").setup()
require("symbols-outline").setup()

END

nnoremap <C-l> :SymbolsOutline<CR>

" }}}
