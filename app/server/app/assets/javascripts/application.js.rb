//= require opal
//= require opal_ujs
//= require redson
//= require_tree .

Document.ready? do
  puts "Hello! Using Redson Version: #{Redson::VERSION} on Opal #{RUBY_ENGINE_VERSION}"
  Student::Widget.new(Element.find("form.new_student")).render
end