module Hello
end

require "hello/echo"

Document.ready? do
  puts "Hello! Using Redson Version: #{Redson::VERSION} #{Redson::COMPILE_TIMESTAMP}"
  Hello::Echo.new(Element["#echo"]).render
end