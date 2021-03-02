set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け
set incsearch
set belloff=all

"indent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent "オートインデント

"=を二回連続入力でバッファ全体をインデント整理
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
Plug 'preservim/nerdtree'
call plug#end()

