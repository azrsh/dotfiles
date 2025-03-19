include_recipe "../../custom_resources/add_1_line"

home = run_command("printenv HOME").stdout.strip

define :tool, repository: nil, revision: nil do
  name = params[:name] 
  repo = params[:repository] || name
  rev = params[:revision]
  dirname = repo.gsub(/^https?:\/\/.*\/([^\/]*)\.git$/, '\1')
  dirpath = "#{home}/.local/tool/#{dirname}"

  package "stow"

  git dirpath do
    repository repo
    revision rev
  end

  execute "chmod in #{dirpath}" do
    # Sometimes, the action is overwritten to :sync, so write it explicitly
    action :nothing 
    command <<EOC
      binaries="$(find #{dirpath} -mindepth 0 -maxdepth 0 -type l)"
      if [ -n "${binaries}" ]; then
        chmod +x $binaries
      fi
EOC
    subscribes :run , "git[#{dirpath}]"
  end

  directory "#{home}/.local/bin"

  execute "symbolic link" do
    action :nothing 
    command <<EOC
      stow -v --no-folding -d #{home}/.local/tool -t #{home}/.local/bin #{dirname}
EOC
    subscribes :run , "git[#{dirpath}]"
  end
end

tool "https://gist.github.com/5fe3daef7f4a81c076e735e4452fe656.git" do
  revision "7a831df62b3adbbdfdb2cb7550b647d0888775ac"
end

tool "https://gist.github.com/39dede61c4b05ffe4b618bf954a91289.git" do
  revision "d96dad8481bd85cce62567787f898afe87bacbef"
end

tool "https://gist.github.com/e0a0ccda7cbf2fe345f1ca6c5bd38d47.git" do
  revision "61d7d9f81ab0e5a71d0446e757d6c1893fa7b003"
end

tool "https://gist.github.com/b8c3ff4907f6e2704cd2b7b9d611f57c.git" do
  revision "435425f362c9bbfd38b6a0c09b749801e0250839"
end

tool "https://gist.github.com/b7755a78253075c22531f88cd4355b7c.git" do
  revision "d98760a58b3d9debae48ff4b3c94d6ea6ed09916"
end

tool "https://gist.github.com/377ca86cdaf119bb61cca8e0a2880217.git" do
  revision "2612cc1536d9372d172bacf1d7ea1a6ddbf5cc79"
end

tool "https://gist.github.com/91149d024587e1feaf37ebf5913bb3c1.git" do
  revision "b926859c9877b3109e4269fa0425116d652a53c1"
end

tool "https://gist.github.com/azrsh/9a57323deed928f7e4580bbdc0b25742.git" do
  revision "2c6c933d832e16db499b135fb8af2aa53d18eeaa"
end

add_1_line "#{home}/.zshenv" do
  line 'PATH="${HOME}/.local/bin:${PATH}"'
end
