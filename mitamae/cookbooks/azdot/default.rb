if node[:platform] == "darwin" then
  package "git"
elsif node[:platform] == "ubuntu" then
  package "git" do
    user "root"
  end
elsif node[:platform] == "arch" then
  package "git" do
    user "root"
  end
else
  MItamae.logger.error "unsupported platform #{node[:platform]}: #{__FILE__}:#{__LINE__}"
  exit 1
end

home = run_command("printenv HOME").stdout.strip
repository = "https://github.com/azrsh/dotfiles"

directory "#{home}/.local/dotfiles"

# Use the execute ressource instead of the git resource to avoid branch name override
execute "git clone #{repository} #{home}/.local/dotfiles" do
  not_if "test -n \"$(ls -A '#{home}/.local/dotfiles')\""
end

directory "#{home}/.local/bin"
remote_file "#{home}/.local/bin/azdot" do
  cwd home
  mode "755"
end
remote_file "#{home}/.local/bin/azdot-install" do
  cwd home
  mode "755"
end
remote_file "#{home}/.local/bin/azdot-update" do
  cwd home
  mode "755"
end
