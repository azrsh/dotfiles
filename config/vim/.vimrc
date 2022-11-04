"editor settings
set number
set title
set showmatch
syntax on
set incsearch
set belloff=all

"indent settings
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

if has('nvim')
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
else    
    "vim-lsp settings
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

    call plug#begin()
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    call plug#end()
endif
