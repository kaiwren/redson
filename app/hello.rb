module Hello
end

require "hello/greeter"

Document.ready? do
  puts "Hello! Opal 001 Version: #{Opal001::VERSION}"
  
  Hello::Greeter.new(target, template).append
end