package "tmux"

home = run_command("printenv HOME").stdout.strip
config_file_path = ".tmux.conf"
remote_file "#{home}/#{config_file_path}" do
  cwd home
end
