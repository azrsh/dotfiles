include_recipe "../../custom_resources/add_1_line"
include_recipe "../../custom_resources/remove_1_line"
include_recipe "../../custom_resources/binary_zip"
include_recipe "../../custom_resources/binary_targz"

home = run_command("printenv HOME").stdout.strip

if node[:platform] == "darwin" then
  package "starship"

  package "zsh-syntax-highlighting"
  add_1_line "#{home}/.zshrc" do
    line 'source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"'
  end

  package "zsh-autosuggestions"
  add_1_line "#{home}/.zshrc" do
    line 'source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"'
  end

  package "gh"
  package "git-lfs"
  package "jq"
  package "peco"
  package "curl"
  package "ghq"
elsif node[:platform] == "ubuntu" then
  package "coreutils" do
    user "root"
  end
  package "curl" do
    user "root"
  end

  url_prefix = "https://github.com/starship/starship/releases/download"
  version = "1.22.1"
  filename = "starship-x86_64-unknown-linux-gnu.tar.gz"
  binary_targz "starship" do
    url File.join(url_prefix, "v#{version}", filename)
    path "starship"
    binary_checksum "08eb5b058e95358a62ff986f273b6b3d8264f7fc5f3889a21a3a99f1955b3388"
    archive_checksum "e57db6f6497ee8a426c5e77b4d6f5c50734d3e9cca7a18a8aef46730505a3ae7"
  end

  # Use starship package in Ubuntu 25.04+
  # package "starship" do
  #   user "root"
  # end

  package "zsh-syntax-highlighting" do
    user "root"
  end
  package "zsh-autosuggestions" do
    user "root"
  end
  package "gh" do
    user "root"
  end
  package "git-lfs" do
    user "root"
  end
  package "jq" do
    user "root"
  end
  package "peco" do
    user "root"
  end
  package "curl" do
    user "root"
  end

  url_prefix = "https://github.com/x-motemen/ghq/releases/download"
  version = "1.8.0"
  filename = "ghq_linux_amd64.zip"
  binary_zip "ghq" do
    url File.join(url_prefix, "v#{version}", filename)
    path "ghq_linux_amd64/ghq"
    binary_checksum "c0f6aa56bdef4df1e35a152030abe4b6498c7b634e8e29ba1f72e418da41780f"
    archive_checksum "ad0ec7b2f52312dca85f35b5c9e88a77447c2c71babbd9dfeb569ab369b8e55f"
  end
elsif node[:platform] == "arch" then
  package "starship" do
    user "root"
  end
  package "zsh-syntax-highlighting" do
    user "root"
  end
  package "zsh-autosuggestions" do
    user "root"
  end
  package "github-cli" do
    user "root"
  end
  package "git-lfs" do
    user "root"
  end
  package "jq" do
    user "root"
  end
  package "peco" do
    user "root"
  end
  package "curl" do
    user "root"
  end
  package "ghq" do
    user "root"
  end
else
  MItamae.logger.error "unsupported platform #{node[:platform]}: #{__FILE__}:#{__LINE__}"
  exit 1
end

add_1_line "#{home}/.zshrc" do
  line 'eval "$(starship init zsh)"'
end

files = [
  ".config/dotfiles/shell/env.zsh",
  ".config/dotfiles/shell/rc.zsh",
]

directory "#{home}/.config/dotfiles/shell"

for file in files
  remote_file "#{home}/#{file}" do
    cwd home
  end
end

add_1_line "#{home}/.zshenv" do
  line 'source "${HOME}/.config/dotfiles/shell/env.zsh"'
end

add_1_line "#{home}/.zshrc" do
  line 'source "${HOME}/.config/dotfiles/shell/rc.zsh"'
end

# Clean up deprecated files
directory "#{home}/.config/dotfile-zsh" do
  action :delete
end

remove_1_line "#{home}/.zshrc" do
  line 'source "${HOME}/.config/dotfile-zsh/rc.zsh"'
end
