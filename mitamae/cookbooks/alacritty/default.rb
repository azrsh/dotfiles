package "coreutils"

url = "https://github.com/alacritty/alacritty/releases/download/v0.13.2/Alacritty-v0.13.2.dmg"
checksum = "c71ce23fc365c4d046de2a48161d26232a5734c519e6b5ff3f55c60258260f60"

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
          "echo '#{archive_expected_checksum}' | sha256sum -c --status"
  not_if "#{install_check_command} || echo '#{archive_expected_checksum}' | sha256sum -c --status"
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

home = run_command("printenv HOME").stdout.strip
directory "#{home}/.config/alacritty"
remote_file "#{home}/.config/alacritty/alacritty.toml" do
  cwd home
end
