class Redson::View
  include Redson::Observable
  
  attr_reader :target_element, :this_element, 
              :template_element, :model, :form
  
  
  def initialize(model, target_element, template_element = nil)
    @target_element = target_element
    @template_element = template_element
    @this_element = template_element ? template_element.clone : target_element
    @this_element = `jQuery(self.this_element)`
    @model = model
    @model.register_observer(
            self, :on => :created
          ).register_observer(
            self, :on => :updated
          ).register_observer(
            self, :on => :unprocessable_entity
          )
          
    initialize_view_elements
    initialize_observable
  end
  
  def initialize_view_elements
  end
  
  def model_created_handler(event)
    raise Redson::Error::TemplateMethodNotOverridenError.new('Redson::View#model_created_handler')
  end

  def model_updated_handler(event)
    raise Redson::Error::TemplateMethodNotOverridenError.new('Redson::View#model_updated_handler')
  end

  def model_unprocessable_entity_handler(event)
    raise Redson::Error::TemplateMethodNotOverridenError.new('Redson::View#model_uprocessable_entity_handler')
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