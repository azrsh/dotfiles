# parameters
# - url: required
# - path: required
# - binary_checksum: required
# - archive_checksum: rquired
# - install_dest: optional, default to '/usr/local/bin'
# - archive_filename: optional, default to File.basename(url), must end with '.zip'
define :binary_targz, url: nil, path: nil, binary_checksum: nil, archive_checksum: nil, install_dest: "/usr/local/bin", archive_filename: nil do
  name = params[:name]
  url = params[:url]
  path = params[:path]
  binary_checksum = params[:binary_checksum]
  archive_checksum = params[:archive_checksum]
  install_dest = params[:install_dest]
  archive_filename = params[:archive_filename] || File.basename(url)

  MItamae.logger.error "Failed to install #{name}, url is missing: #{__FILE__}:#{__LINE__}" unless url
  MItamae.logger.error "Failed to install #{name}, path is missing: #{__FILE__}:#{__LINE__}" unless path
  MItamae.logger.error "Failed to install #{name}, binary_checksum is missing: #{__FILE__}:#{__LINE__}" unless binary_checksum
  MItamae.logger.error "Failed to install #{name}, archive_checksum is missing: #{__FILE__}:#{__LINE__}" unless archive_checksum

  MItamae.logger.error "Failed to install #{name}, invalid archive filename #{archive_filename}: #{__FILE__}:#{__LINE__}" unless archive_filename.end_with?(".tar.gz")

  archive_basename = archive_filename.delete_suffix(".tar.gz")
  archive_filepath = File.join("/tmp", archive_basename, archive_filename)
  archive_expected_checksum = "#{archive_checksum}  #{archive_filepath}"

  expected_binary_checksum = "#{binary_checksum}  #{File.join(install_dest, name)}"
  install_check_command = "echo '#{expected_binary_checksum}' | sha256sum -c --status"

  execute "download #{name}" do
    command "mkdir -p /tmp/#{archive_basename} && " \
            "cd /tmp/#{archive_basename} && " \
            "curl -fsSLO #{url} && " \
            "echo '#{archive_expected_checksum}' | sha256sum -c --status"
    not_if "#{install_check_command} || echo '#{archive_expected_checksum}' | sha256sum -c --status"
  end

  execute "install #{name}" do
    command "tar xvzofC #{archive_filepath} #{install_dest} #{path}"
    user "root"
    not_if install_check_command
  end

  local_ruby_block "ensure #{name}" do
    block do
      MItamae.logger.error "Failed to install #{name}: #{__FILE__}:#{__LINE__}"
      exit 1
    end
    not_if install_check_command
  end
end
