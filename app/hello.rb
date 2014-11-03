module Hello
end

require "hello/greeter"

Document.ready? do
  puts "Hello! Using Redson Version: #{Redson::VERSION}"
  Hello::Greeter.new(Element["#greeter"]).render
end