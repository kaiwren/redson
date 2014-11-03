module Hello
end

require "hello/greeter"

Document.ready? do
  puts "Hello! Opal 001 Version: #{Redson::VERSION}"
  Hello::Greeter.new(Element["#greeter"]).render
end