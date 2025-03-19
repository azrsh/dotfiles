home = run_command("printenv HOME").stdout.strip

directory "#{home}/.docker"

file "#{home}/.docker/config.json" do
  cwd home
  action [:create, :edit]
  block do |content|
    hash = if content != "" then JSON.parse(content) else {} end
    merged = hash.merge({"credHelpers"=>{"ghcr.io"=>"gh"}}) {|key, v1, v2| v1.merge(v2) }

    # It breaks default configuration file format
    if hash != merged then
      content[0..-1] = JSON.pretty_generate(merged)
      content << "\n"
    end
  end
end
