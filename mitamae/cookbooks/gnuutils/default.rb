include_recipe "../../custom_resources/add_1_line"

package "binutils"
package "coreutils"
package "diffutils"
package "findutils"
package "moreutils"

home = run_command("printenv HOME").stdout.strip
dirpath = ".config/dotfiles/gnuutils"
filename = "env.zsh"

directory "#{home}/#{dirpath}"

remote_file "#{home}/#{dirpath}/#{filename}" do
  cwd home
end

add_1_line "#{home}/.zshenv" do
  line "source \"${HOME}/#{dirpath}/#{filename}\""
end
