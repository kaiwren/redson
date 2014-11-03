class Opal001::Widget
  def initialize(target_element, template_element)
    @target_element = target_element
    @template_element = template_element
    @this_element = template_element.clone
  end
  
  def append
    @target_element.append(@this_element)
  end
end