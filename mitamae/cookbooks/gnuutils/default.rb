include_recipe "../../custom_resources/add_1_line"

if node[:platform] == "darwin" then
  package "binutils"
  package "coreutils"
  package "diffutils"
  package "findutils"
  package "moreutils"
elsif node[:platform] == "ubuntu" then
  package "binutils" do
    user "root"
  end
  package "coreutils" do
    user "root"
  end
  package "diffutils" do
    user "root"
  end
  package "findutils" do
    user "root"
  end
  package "moreutils" do
    user "root"
  end
elsif node[:platform] == "arch" then
  package "binutils" do
    user "root"
  end
  package "coreutils" do
    user "root"
  end
  package "diffutils" do
    user "root"
  end
  package "findutils" do
    user "root"
  end
  package "moreutils" do
    user "root"
  end
else
  MItamae.logger.error "unsupported platform #{node[:platform]}: #{__FILE__}:#{__LINE__}"
  exit 1
end

home = run_command("printenv HOME").stdout.strip
dirpath = ".config/dotfiles/gnuutils"
filename = "env.zsh"

directory "#{home}/#{dirpath}"

remote_file "#{home}/#{dirpath}/#{filename}" do
  cwd home
end

add_1_line "#{home}/.zshenv" do
  line "source \"${HOME}/#{dirpath}/#{filename}\""
end
