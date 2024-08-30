include_recipe "../../custom_resources/add_1_line"

package "direnv"

home = run_command("printenv HOME").stdout.strip
add_1_line "#{home}/.zshenv" do
  line 'eval "$(direnv hook zsh)"'
end
