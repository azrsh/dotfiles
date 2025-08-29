if node[:platform] == "darwin" then
  package "coreutils"

  home = run_command("printenv HOME").stdout.strip

  # renovate: datasource=github-releases depName=ryanoasis/nerd-fonts versioning=semver
  version = "3.2.1"
  url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v#{version}/FiraCode.zip"
  checksum = "7e49cee33e358a3f861dc2c1117a6f0d12d04d1e3c4e3ca4b6d74f550ff7aa9c"
  archive_checksum = "4ee8fbafecfc90460399b9828270b8ece30ccbf60b3ab875d64ff77696c6e262"
  install_dest = "#{home}/Library/Fonts/"
  file_name = "FiraCodeNerdFont-Regular.ttf"

  archive_filename = File.basename(url)
  archive_basename = archive_filename.delete_suffix(".zip")
  archive_expected_checksum = "#{archive_checksum}  #{File.join("/tmp", archive_basename, archive_filename)}"

  file_path = File.join("/tmp", archive_basename, file_name)
  file_expected_checksum = "#{checksum}  #{file_path}"

  expected_checksum = "#{checksum}  #{File.join(install_dest, file_name)}"
  install_check_command = "echo '#{expected_checksum}' | gsha256sum -c --status"

  # Use curl to support MacOS
  execute "download FiraCode" do
    command "mkdir -p /tmp/#{archive_basename} && " \
            "cd /tmp/#{archive_basename} && " \
            "curl -fsSLO #{url} && " \
            "echo '#{archive_expected_checksum}' | gsha256sum -c --status"
    not_if "#{install_check_command} || echo '#{archive_expected_checksum}' | gsha256sum -c --status"
  end

  execute "unzip FiraCode Nerd Font" do
    command "cd /tmp/#{archive_basename} && " \
            "unzip #{archive_filename} && " \
            "echo '#{file_expected_checksum}' | gsha256sum -c --status"
    not_if "#{install_check_command} || echo '#{file_expected_checksum}' | gsha256sum -c --status"
  end

  execute "install FiraCode Nerd Font" do
    command "cd /tmp/#{archive_basename} && " \
            "mv #{file_path} #{install_dest}"
    not_if install_check_command
  end
elsif node[:platform] == "ubuntu" then
  package "fonts-firacode" do
    user "root"
  end
elsif node[:platform] == "arch" then
  package "ttf-firacode-nerd" do
    user "root"
  end
else
  MItamae.logger.error "unsupported platform #{node[:platform]}: #{__FILE__}:#{__LINE__}"
  exit 1
end
