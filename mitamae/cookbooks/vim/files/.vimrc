"editor settings
set number
set title
set showmatch
syntax on
set incsearch
set belloff=all
set list
set listchars=tab:>\ 
set re=0
set mouse=a
set hlsearch

"indent settings
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent

set clipboard^=unnamedplus,unnamed

if has('nvim')
    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
else
    let g:lsp_diagnostics_virtual_text_enabled = 0
    let g:lsp_diagnostics_float_cursor = 1
    nnoremap ==     :LspDocumentFormat<CR>
    nnoremap <c-]>  :LspDefinition<CR>
    nnoremap K      :LspHover<CR>
    nnoremap gD     :LspImplementation<CR>
    nnoremap <c-k>  :LspSignatureHelp<CR>
    nnoremap 1gD    :LspTypeDefinition<CR>
    nnoremap gr     :LspReferences<CR>
    nnoremap g0     :LspDocumentSymbol<CR>
    nnoremap gW     :LspWorkspaceSymbol<CR>
    nnoremap gd     :LspDeclaration<CR>
    nnoremap ]e     :LspNextError<CR>
    nnoremap [e     :LspPreviousError<CR>
endif
