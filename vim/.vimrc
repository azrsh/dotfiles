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
set smartindent "オートインデント

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

"NERDTree settings
autocmd VimEnter * NERDTree | wincmd p
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

call plug#begin()
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'preservim/nerdtree'
call plug#end()

