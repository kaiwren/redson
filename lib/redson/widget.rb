class Redson::Widget
  TEMPLATES_ELEMENT_MATCHER = "#r-templates"
  TEMPLATE_ELEMENT_MATCHER = ".r-template"
  ELEMENT_MATCHER = ".r-element"
  INPUT_TYPE_ATTRIBUTE_MATCHER = "[data-rs-type='input']"
  
  DEFAULTS = 'defaults'
  BINDINGS = 'bindings'
  
  def self.inherited(base_klass)
    base_klass.class_eval do
      initialize_widget_klass
    end
  end
  
  def self.initialize_widget_klass
    @rs_widget_state = {}
    @rs_widget_state[DEFAULTS] = {}
    @rs_widget_state[BINDINGS] = []
    @rs_widget_state['widget_name'] = self.name.split(/::/).last.downcase
    @rs_widget_state[DEFAULTS]['template_element_matcher'] = "#{TEMPLATE_ELEMENT_MATCHER}.#{widget_name}"
  end
    
  def initialize(target_element)
    @target_element = target_element
    @template_element = Element.find!(template_element_matcher)
    @this_element = template_element.clone
    @bound_values = {}
    setup_bindings
  end
  
  def setup_bindings
    self.class.bindings.each do |binding|
      binding.create_for(self)
    end
  end
  
  def bind(element_matcher, to, event_name_to_update_on, notify)
    element = this_element.find!(element_matcher)
    element.on(event_name_to_update_on) do |event|
      @bound_values[to] = element.value
      self.method(notify).call(event)
    end
  end
    
  def find_elements_marked_as_input
    this_element.find("#{ELEMENT_MATCHER}#{INPUT_TYPE_ATTRIBUTE_MATCHER}")
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
  
  def self.bind(element_matcher, options)
    @rs_widget_state[BINDINGS] << Binding.new(element_matcher, options)
  end
  
  def self.widget_name
    @rs_widget_state['widget_name']
  end
  
  def self.bindings
    @rs_widget_state[BINDINGS]
  end
  
  def self.target_element_matcher(matcher)
    @rs_widget_state[DEFAULTS]['target_element_matcher'] = matcher
  end

  def self.target_element_matcher
    @rs_widget_state[DEFAULTS]['target_element_matcher']
  end

  def self.template_element_matcher(matcher)
    @rs_widget_state[DEFAULTS]['template_element_matcher'] = matcher
  end

  def self.template_element_matcher
    @rs_widget_state[DEFAULTS]['template_element_matcher']
  end
  
  def widget_name
    self.class.widget_name
  end
  
  def target_element_matcher
    self.class.target_element_matcher
  end
  
  def template_element_matcher
    self.class.template_element_matcher
  end
end