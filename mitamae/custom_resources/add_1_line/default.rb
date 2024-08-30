define :add_1_line, path: nil, line: nil do
  name = params[:name] 
  path = params[:path] || name
  line = params[:line]

  file path do
    action :edit
    block do |content|
      unless content.start_with?("#{line}\n") or content.include?("\n#{line}\n") then
        content << "\n#{line}\n"
      end
    end
  end
end
