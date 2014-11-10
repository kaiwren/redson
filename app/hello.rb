module Hello
end

require "hello/echo"

Document.ready? do
  puts "Hello! Using Redson Version: #{Redson::VERSION} #{Redson::COMPILE_TIMESTAMP}"
  widgets = Hello::Echo.instantiate_all_in_document
  widgets.each {|w| w.render }
end