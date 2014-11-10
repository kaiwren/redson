require "hello/echo"

Document.ready? do
  puts "Hello! Using Redson Version: #{Redson::VERSION} #{Redson::COMPILE_TIMESTAMP} on Opal #{RUBY_ENGINE_VERSION}"
  widgets = Hello::Echo::Widget.instantiate_all_in_document
  widgets.each {|w| w.render }
end