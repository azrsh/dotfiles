include_recipe "../../custom_resources/add_1_line"
include_recipe "../../custom_resources/remove_1_line"

home = run_command("printenv HOME").stdout.strip

package "starship"
add_1_line "#{home}/.zshrc" do
  line 'eval "$(starship init zsh)"'
end

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
