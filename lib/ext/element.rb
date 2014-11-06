# reopening opal-jquery object
class Element
  def self.find!(selector)
    elements = self.find(selector)
    raise "No elements matching #{selector} found" if elements.empty?
    elements
  end
  
  def find!(selector)
    elements = self.find(selector)
    raise "No elements matching #{selector} found inside #{self.inspect}" if elements.empty?
    elements
  end
  
  def input?
    attr('data-rs-type') == 'input'
  end
end