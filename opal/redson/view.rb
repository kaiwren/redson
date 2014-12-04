class Redson::View
  attr_reader :target_element, :this_element, 
              :template_element, :model, :form
  
  
  def initialize(model, target_element, template_element = nil)
    @target_element = target_element
    @template_element = template_element
    @this_element = template_element ? template_element.clone : target_element
    @this_element = `jQuery(self.this_element)`
    @model = model
    initialize_view_elements
    @model.register_observer(
            self, :on => :created
          ).register_observer(
            self, :on => :updated
          ).register_observer(
            self, :on => :unprocessable_entity
          )
  end
  
  def model_created_handler(event)
    Kernel.p :model_created_handler
  end

  def model_updated_handler(event)
    Kernel.p :model_updated_handler
  end

  def model_unprocessable_entity_handler(event)
    Kernel.p :model_unprocessable_entity_handler
    model.errors.each do |key, values|
      target_element.find("input[name=#{model.attributes_namespace}\\[#{key}\\]]").add_class("error")
    end
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