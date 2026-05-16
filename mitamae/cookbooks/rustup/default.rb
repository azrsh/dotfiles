include_recipe "../../custom_resources/add_1_line"

version = "1.27.1"

if node[:platform] == "darwin" then
  target_triple = "aarch64-apple-darwin"
  
  url = "https://static.rust-lang.org/rustup/archive/#{version}/#{target_triple}/rustup-init"
  checksum = "760b18611021deee1a859c345d17200e0087d47f68dfe58278c57abe3a0d3dd0"
  filename = File.basename(url)
  filepath = File.join("/tmp/rustup", filename)
  
  expected_checksum = "#{checksum}  #{filepath}"
  
  # Use curl to support MacOS
  execute "install rustup" do
    command "mkdir -p /tmp/rustup && " \
            "cd /tmp/rustup && " \
            "curl -fsSLO #{url} && " \
            "echo '#{expected_checksum}' | sha256sum -c --status - && " \
            "chmod +x #{filepath} && " \
            "#{filepath} -y"
    not_if "rustup --version"
  end
elsif node[:platform] == "ubuntu" then
  target_triple = "x86_64-unknown-linux-gnu"
  
  url = "https://static.rust-lang.org/rustup/archive/#{version}/#{target_triple}/rustup-init"
  checksum = "6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d"
  filename = File.basename(url)
  filepath = File.join("/tmp/rustup", filename)
  
  expected_checksum = "#{checksum}  #{filepath}"
  
  # Use curl to support MacOS
  execute "install rustup" do
    command "mkdir -p /tmp/rustup && " \
            "cd /tmp/rustup && " \
            "curl -fsSLO #{url} && " \
            "echo '#{expected_checksum}' | sha256sum -c --status - && " \
            "chmod +x #{filepath} && " \
            "#{filepath} -y"
    not_if "rustup --version"
  end
elsif node[:platform] == "arch" then
  target_triple = "x86_64-unknown-linux-gnu"
  
  url = "https://static.rust-lang.org/rustup/archive/#{version}/#{target_triple}/rustup-init"
  checksum = "6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d"
  filename = File.basename(url)
  filepath = File.join("/tmp/rustup", filename)
  
  expected_checksum = "#{checksum}  #{filepath}"
  
  # Use curl to support MacOS
  execute "install rustup" do
    command "mkdir -p /tmp/rustup && " \
            "cd /tmp/rustup && " \
            "curl -fsSLO #{url} && " \
            "echo '#{expected_checksum}' | sha256sum -c --status - && " \
            "chmod +x #{filepath} && " \
            "#{filepath} -y"
    not_if "rustup --version"
  end
else
  MItamae.logger.error "unsupported platform #{node[:platform]}: #{__FILE__}:#{__LINE__}"
  exit 1
end

home = run_command("printenv HOME").stdout.strip

add_1_line "#{home}/.zshenv" do
  line '. "$HOME/.cargo/env"'
end
