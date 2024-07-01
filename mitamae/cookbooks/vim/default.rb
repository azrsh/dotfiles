home = run_command("printenv HOME").stdout.strip

# vim
git "#{home}/.vim/pack/lsp/start/async.vim" do
  repository "https://github.com/prabirshrestha/async.vim"
  revision "2082d13bb195f3203d41a308b89417426a7deca1" # master
end

git "#{home}/.vim/pack/lsp/start/asyncomplete.vim" do
  repository "https://github.com/prabirshrestha/asyncomplete.vim"
  revision "016590d2ca73cefe45712430e319a0ef004e2215" # master
end

git "#{home}/.vim/pack/lsp/start/asyncomplete-lsp.vim" do
  repository "https://github.com/prabirshrestha/asyncomplete-lsp.vim"
  revision "cc5247bc268fb2c79d8b127bd772514554efb3ee" # master
end

git "#{home}/.vim/pack/lsp/start/vim-lsp" do
  repository "https://github.com/prabirshrestha/vim-lsp"
  revision "6b7aabde99c409a3c04e1a7d80bbd1b0000c4158" # master
end

git "#{home}/.vim/pack/lsp/start/vim-lsp-settings" do
  repository "https://github.com/mattn/vim-lsp-settings"
  revision "65749446c8c8556d0c287bcd724084a625913d02" # master
end

git "#{home}/.vim/pack/github/start/copilot.vim" do
  repository "https://github.com/github/copilot.vim.git"
  revision "25f73977033c597d530c7ab0e211d99b60927d2d" # v1.38.0
end

remote_file "#{home}/.vimrc" do
  cwd home
end

# nvim
git "#{home}/.config/nvim/pack/lsp/start/nvim-lspconfig" do
  repository "https://github.com/neovim/nvim-lspconfig"
  revision "e6528f4613c8db2e04be908eb2b5886d63f62a98" # master
end

remote_file "#{home}/.config/nvim/init.vim" do
 source "files/.vimrc"
end
