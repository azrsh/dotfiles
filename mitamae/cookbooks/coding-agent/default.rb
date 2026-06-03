home = run_command("printenv HOME").stdout.strip

directory "#{home}/.agents/skills/adr"
remote_file "#{home}/.agents/skills/adr/SKILL.md" do
  cwd home
end

directory "#{home}/.claude/skills"
link "#{home}/.claude/skills" do
  to "#{home}/.agents/skills"
end
