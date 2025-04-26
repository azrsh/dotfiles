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

command! Pe bd | setlocal buftype=nofile | execute 'r!git ls-files | peco' | e <cfile>

function! RangeToGithubUrl(path, line1, line2) abort
  const l:repo_url = trim(system("gh repo view --json=url -q='.url'"))
  if v:shell_error
    throw "Failed to get GitHub repository URL"
  endif
  const l:rev = trim(system("git rev-parse HEAD"))
  if v:shell_error
    throw "Failed to get Git revision"
  endif
  const l:path_in_repo = trim(system("git ls-files --full-name " . a:path))
  if v:shell_error
    throw  "Failed to get file path"
  endif

  if a:line1 < a:line2
    return printf("%s/blame/%s/%s#L%d-L%d", l:repo_url, l:rev, l:path_in_repo, a:line1, a:line2)
  elseif a:line1 == a:line2
    return printf("%s/blame/%s/%s#L%d", l:repo_url, l:rev, l:path_in_repo, a:line1)
  else
    return printf("%s/blame/%s/%s#L%d-L%d", l:repo_url, l:rev, l:path_in_repo, a:line2, a:line1)
  endif
endfunction
function! YankGithubUrl(path, line1, line2) abort
  const l:url = RangeToGithubUrl(a:path, a:line1, a:line2)
  call setreg(v:register, l:url)
  echo printf("yanked %s", l:url)
endfunction
command! -range Yg call YankGithubUrl(expand("%:p"), <line1>, <line2>)

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
