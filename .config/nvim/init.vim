set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け
set incsearch

"indent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent "オートインデント

"=を二回連続入力でバッファ全体をインデント整理
nnoremap == :LspDocumentFormat<Return>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>

call plug#begin()
Plug 'neovim/nvim-lspconfig'
call plug#end()

