COMMIT = "f31ffd3ee38539c66207e0551a31f09e71d5345a"

url = "https://raw.githubusercontent.com/Homebrew/install/#{COMMIT}/install.sh"
checksum = "7890"
filename = File.basename(url)
filepath = File.join("/tmp/homwbrew", filename)

expected_checksum = "#{checksum}  #{filepath}"
install_check_command = "brew --version"

execute "install homebrew" do
  command "mkdir -p /tmp/homebrew &&" \
          "cd /tmp/homebrew && " \
          "wget #{url} && " \
          "echo '#{expected_checksum}' | sha256sum -c --status &&" \
          "#{filepath}"
  not_if install_check_command
end

execute "clean workdir" do
  command "rm -rf /tmp/homebrew"
  only_if "test -d /tmp/homebrew"
end
