if node[:platform] == "darwin" then
  package "coreutils"

  url = "https://github.com/alacritty/alacritty/releases/download/v0.15.1/Alacritty-v0.15.1.dmg"
  checksum = "abaf240980cf3378031d1bfb3473d3b36abac15d679e2f780d5c0f09aa218459"

  archive_filename = File.basename(url)
  archive_basename = archive_filename.delete_suffix(".dmg")
  archive_filepath = File.join("/tmp", archive_basename, archive_filename)
  archive_expected_checksum = "#{checksum}  #{archive_filepath}"

  install_check_command = "test -d /Applications/Alacritty.app"

  # Use curl to support MacOS
  execute "download Alacritty" do
    command "mkdir -p /tmp/#{archive_basename} && " \
            "cd /tmp/#{archive_basename} && " \
            "curl -fsSLO #{url} && " \
            "echo '#{archive_expected_checksum}' | gsha256sum -c --status"
    not_if "#{install_check_command} || echo '#{archive_expected_checksum}' | gsha256sum -c --status"
  end

  execute "install Alacritty" do
    command "cd /tmp/#{archive_basename} && " \
            "hdiutil attach -nobrowse #{archive_filepath} && " \
            "cp -r /Volumes/Alacritty/Alacritty.app /Volumes/Alacritty/Applications/"
    not_if install_check_command
  end

  execute "detach Alacritty" do
    command "hdiutil detach /Volumes/Alacritty"
    only_if "test -d /Volumes/Alacritty"
  end
elsif node[:platform] == "ubuntu" then
  package "alacritty" do
    user "root"
  end
elsif node[:platform] == "arch" then
  package "alacritty" do
    user "root"
  end
else
  MItamae.logger.error "unsupported platform #{node[:platform]}: #{__FILE__}:#{__LINE__}"
  exit 1
end

home = run_command("printenv HOME").stdout.strip
directory "#{home}/.config/alacritty"
remote_file "#{home}/.config/alacritty/alacritty.toml" do
  cwd home
end
