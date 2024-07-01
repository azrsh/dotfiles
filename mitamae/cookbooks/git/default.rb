home = run_command("printenv HOME").stdout.strip

files = [
  ".gitconfig",
  ".config/git/ignore",
  ".config/git/template/hooks/pre-push",
]

directory "#{home}/.config/git/template/hooks"

for file in files
  remote_file "#{home}/#{file}" do
    cwd home
  end
end
