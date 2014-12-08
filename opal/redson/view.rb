class Redson::View
  KEY_PUBLISHED_EVENTS = "published_events"
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
            self, :on => :request_started
          ).register_observer(
            self, :on => :request_ended
          ).register_observer(
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
    Redson.l.d("Template method #{self}#initialize_view_elements called. Override to do something different.")
  end
  
  def model_request_started_handler(event)
    Redson.l.d("Handler #{self}#model_request_started_handler called. Override to do something different.")
  end

  def model_request_ended_handler(event)
    Redson.l.d("Handler #{self}#model_request_ended_handler called. Override to do something different.")
  end
  
  def model_created_handler(event)
    Redson.l.d("Handler #{self}#model_created_handler called. Override to do something different.")
  end

  def model_updated_handler(event)
    Redson.l.d("Handler #{self}#model_updated_handler called. Override to do something different.")
  end

  def model_unprocessable_entity_handler(event)
    Redson.l.d("Handler #{self}#model_uprocessable_entity_handler called. Override to do something different." )
  end
  
  def find_element!(matcher)
    this_element.find!(matcher)
  end
  
  def render
    target_element.append(this_element) unless target_element == this_element
  end
  
  def bind(element_matcher, to, event_name_to_update_on, notification_handler = nil)
    element = this_element.find!(element_matcher)
    element.on(event_name_to_update_on) do |event|
      model[to] = element.value
      notification_handler_method = self.method(notification_handler)
      notification_handler_method.call(event) if notification_handler_method
    end
  end
end