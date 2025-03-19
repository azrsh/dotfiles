define :remove_1_line, path: nil, line: nil do
  name = params[:name] 
  path = params[:path] || name
  line = params[:line]

  file path

  file path do
    action :edit
    block do |content|
      if content.gsub!("\n#{line}\n", "\n") then
        content.rstrip!
        content << "\n"
      end
      if content.start_with?("#{line}\n") then
        content.sub!("#{line}\n", "")
      end
    end
  end
end
