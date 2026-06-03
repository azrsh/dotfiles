include_recipe "../../custom_resources/add_1_line"

COMMIT = "f31ffd3ee38539c66207e0551a31f09e71d5345a"

url = "https://raw.githubusercontent.com/Homebrew/install/#{COMMIT}/install.sh"
checksum = "67b0989bd0a404cdd32c1df20e3fb724b7c278c83a068fd5a16dac6f8d317a79"
filename = File.basename(url)
filepath = File.join("/tmp/homebrew", filename)

expected_checksum = "#{checksum}  #{filepath}"
install_check_command = "brew --version"

execute "install homebrew" do
  command "mkdir -p /tmp/homebrew &&" \
          "cd /tmp/homebrew && " \
          "curl -fsSLO #{url} && " \
          "echo '#{expected_checksum}' | sha256sum -c --status - && " \
          "chmod +x #{filepath} && " \
          "#{filepath}"
  not_if install_check_command
end

execute "clean workdir" do
  command "rm -rf /tmp/homebrew"
  only_if "test -d /tmp/homebrew"
end

home = run_command("printenv HOME").stdout.strip
add_1_line "#{home}/.zshenv" do
  line 'eval "$(/opt/homebrew/bin/brew shellenv)"'
end

execute "brew upgrade" do
  not_if "test -z \"$(brew outdated -q)\""
end
