module Hello
end

require "hello/greeter"

Document.ready? do
  puts "Hello! Opal 001 Version: #{Opal001::VERSION}"

  Hello::Greeter.new(Element["#target"], Element["#templates .o-greeter-template"]).render
end