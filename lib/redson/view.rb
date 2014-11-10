class Redson::View
  def initialize(target_element, template_element)
    @target_element = target_element
    @template_element = template_element
    @this_element = template_element.clone
  end
  
  def render
    target_element.append(this_element)
  end
  
  def find_elements_marked_as_input
    this_element.find("#{ELEMENT_MATCHER}#{INPUT_TYPE_ATTRIBUTE_MATCHER}")
  end
  
  def target_element
    @target_element
  end
  
  def this_element
    @this_element
  end
  
  def template_element
    @template_element
  end
end