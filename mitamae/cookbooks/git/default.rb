if node[:platform] == "darwin" then
  package "git"
  link "/usr/local/bin/diff-highlight" do
    user "root"
    to "/opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight"
    force true
  end
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

files = [
  ".gitconfig",
  ".config/git/ignore",
  ".config/git/template/hooks/pre-push",
]

directory "#{home}/.config/git/template/hooks"

for file in files
  remote_file "#{home}/#{file}" do
    cwd home
  end
end
