class Redson::Widget
  TEMPLATES_ELEMENT_MATCHER = "#o-templates"
  TEMPLATE_ELEMENT_MATCHER = ".o-template"
  
  def self.widget_name
    self.name.split(/::/).last.downcase
  end
  
  def initialize(target_element)
    @target_element = target_element
    @template_element = Element.find!("#{TEMPLATES_ELEMENT_MATCHER} #{TEMPLATE_ELEMENT_MATCHER}.#{widget_name}")
    @this_element = template_element.clone
  end
    
  def widget_name
    self.class.widget_name
  end
  
  def this_element
    @this_element
  end
  
  def template_element
    @template_element
  end
  
  def render
    @target_element.append(@this_element)
  end
end