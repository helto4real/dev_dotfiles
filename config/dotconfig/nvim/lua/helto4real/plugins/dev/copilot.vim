 
imap <silent><script><expr> <C-h> copilot#Accept("\<CR>")
imap <silent><script><expr> <C-ö> copilot#Dismiss()
imap <silent><script><expr> <C-j> copilot#Next()
imap <silent><script><expr> <C-k> copilot#Previous()
let g:copilot_no_tab_map = v:true
let g:copilot_no_dismiss_map = v:true
