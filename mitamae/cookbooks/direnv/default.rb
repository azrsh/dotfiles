include_recipe "../../custom_resources/add_1_line"

if node[:platform] == "darwin" then
  package "direnv"
elsif node[:platform] == "ubuntu" then
  package "direnv" do
    user "root"
  end
elsif node[:platform] == "arch" then
  package "direnv" do
    user "root"
  end
else
  MItamae.logger.error "unsupported platform #{node[:platform]}: #{__FILE__}:#{__LINE__}"
  exit 1
end

home = run_command("printenv HOME").stdout.strip
add_1_line "#{home}/.zshenv" do
  line 'eval "$(direnv hook zsh)"'
end
