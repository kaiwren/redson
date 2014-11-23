class Redson::View
  attr_reader :target_element, :this_element, 
              :template_element, :model, :form
  
  
  def initialize(model, target_element, template_element)
    @target_element = target_element
    @template_element = template_element
    @this_element = template_element ? template_element.clone : target_element
    @model = model
    if target_element.is('form')
      @form = Redson::Form.new(target_element)
      form.input_elements.each do |element|
        model[element['name']] = element.value
      end
      form.ajaxify! do |event|
        model.save
      end
      form.disable_submit_event_propagation!
      model.api_path = form.action_attribute
      p model
    end
    initialize_view_elements
  end
  
  def initialize_view_elements
    raise "initialize_view_elements must be overriden in #{self.class}"
  end
  
  def find_element!(matcher)
    this_element.find!(matcher)
  end
  
  def render
    target_element.append(this_element) unless target_element == this_element
  end
      
  def bind(element_matcher, to, event_name_to_update_on, notification_handler)
    element = this_element.find!(element_matcher)
    element.on(event_name_to_update_on) do |event|
      model[to] = element.value
      self.method(notification_handler).call(event)
    end
  end
end