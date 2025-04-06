if node[:platform] == "darwin" then
  package "tmux"
elsif node[:platform] == "ubuntu" then
  package "tmux" do
    user "root"
  end
elsif node[:platform] == "arch" then
  package "tmux" do
    user "root"
  end
else
  MItamae.logger.error "unsupported platform #{node[:platform]}: #{__FILE__}:#{__LINE__}"
  exit 1
end

home = run_command("printenv HOME").stdout.strip
config_file_path = ".tmux.conf"
remote_file "#{home}/#{config_file_path}" do
  cwd home
end
