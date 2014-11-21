class Redson::View
  attr_reader :target_element, :this_element, 
              :template_element, :model, :api_url
  
  def initialize(model, target_element, template_element)
    @target_element = target_element
    @template_element = template_element
    @this_element = template_element ? template_element.clone : target_element
    @model = model
    setup_form if target_element.is('form')
    initialize_view_elements
  end
  
  def initialize_view_elements
    raise "initialize_view_elements must be overriden in #{self.class}"
  end
  
  def form_action_url
  end
  
  def find_form
  end
  
  def setup_form
    @api_url = target_element.attr('action')
    puts @api_url
  end
  
  def find_element!(matcher)
    this_element.find!(matcher)
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