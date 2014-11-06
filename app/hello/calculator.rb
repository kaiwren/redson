module Hello
  class Calculator < Redson::Widget
  end
end

require File.expand_path(File.join(File.dirname(__FILE__), "calculator", "model"))
require File.expand_path(File.join(File.dirname(__FILE__), "calculator", "view"))