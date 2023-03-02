let g:Lf_PreviewInPopup = 1
" open the preview window automatically
let g:Lf_PreviewResult = {'Rg': 1 }
let g:Lf_UseCache = 0
let g:Lf_UseMemoryCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_CommandMap = {'<C-K>': ['<C-P>'], '<C-J>': ['<C-N>']}

" search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <C-J> :<C-U><C-R>=printf("Leaderf! rg -e ")<CR>

noremap <C-F> :LeaderfFile<CR>
