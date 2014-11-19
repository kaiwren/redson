class Redson::View
  attr_reader :target_element, :this_element, 
              :template_element, :model
  
  def initialize(target_element, template_element, model)
    @target_element = target_element
    @template_element = template_element
    @this_element = template_element.clone
    @model = model
    load_view_elements
  end
  
  def load_view_elements
    raise "load_view_elements must been overriden in #{self.class}"
  end
  
  def render
    target_element.append(this_element)
  end
  
  def find_elements_marked_as_input
    this_element.find("#{ELEMENT_MATCHER}#{INPUT_TYPE_ATTRIBUTE_MATCHER}")
  end
  
  def bind(element_matcher, to, event_name_to_update_on, notification_handler)
    element = this_element.find!(element_matcher)
    element.on(event_name_to_update_on) do |event|
      model[to] = element.value
      self.method(notification_handler).call(event)
    end
  end
end