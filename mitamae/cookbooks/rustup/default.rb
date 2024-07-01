VERSION = "1.27.1"
TARGET_TRIPLE = "aarch64-apple-darwin"

url = "https://static.rust-lang.org/rustup/archive/#{VERSION}/#{TARGET_TRIPLE}/rustup-init"
checksum = "7890"
filename = File.basename(url)
filepath = File.join("/tmp/rustup", filename)

expected_checksum = "#{checksum}  #{filepath}"
install_check_command = "rustup --version"

execute "install rustup" do
  command "mkdir -p /tmp/rustup &&" \
          "cd /tmp/rustup && " \
          "wget #{url} && " \
          "echo '#{expected_checksum}' | sha256sum -c --status &&" \
          "#{filepath}"
  not_if install_check_command
end

execute "clean workdir" do
  command "rm -rf /tmp/rustup"
  only_if "test -d /tmp/rustup"
end
