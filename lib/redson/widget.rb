class Redson::Widget
  TEMPLATES_ELEMENT_MATCHER = "#r-templates"
  TEMPLATE_ELEMENT_MATCHER = ".r-template"
  ELEMENT_MATCHER = ".r-element"
  INPUT_TYPE_ATTRIBUTE_MATCHER = "[data-rs-type='input']"
  
  KEY_DEFAULTS = 'defaults'
  KEY_BINDINGS = 'bindings'
  KEY_WIDGET_NAME = 'widget_name'
  KEY_TEMPLATE_ELEMENT_MATCHER = 'template_element_matcher'
  KEY_TARGET_ELEMENT_MATCHER = 'target_element_matcher'
  
  def self.inherited(base_klass)
    base_klass.initialize_widget_klass
  end
  
  def initialize
    @target_element = Element.find!(target_element_matcher)
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
  
  def widget_name
    self.class.widget_name
  end
  
  def target_element_matcher
    self.class.target_element_matcher
  end
  
  def template_element_matcher
    self.class.template_element_matcher
  end
  
  def self.initialize_widget_klass
    @rs_widget_state = {}
    @rs_widget_state[KEY_DEFAULTS] = {}
    @rs_widget_state[KEY_BINDINGS] = []
    @rs_widget_state[KEY_WIDGET_NAME] = self.name.split(/::/).last.downcase
    @rs_widget_state[KEY_DEFAULTS][KEY_TEMPLATE_ELEMENT_MATCHER] = "#{TEMPLATE_ELEMENT_MATCHER}.#{widget_name}"
  end
  
  def self.bind(element_matcher, options)
    @rs_widget_state[KEY_BINDINGS] << Binding.new(element_matcher, options)
  end
  
  def self.widget_name
    @rs_widget_state[KEY_WIDGET_NAME]
  end
  
  def self.bindings
    @rs_widget_state[KEY_BINDINGS]
  end
    
  def self.target_element_matcher
    @rs_widget_state[KEY_DEFAULTS][KEY_TARGET_ELEMENT_MATCHER]
  end
  
  # We're using the 'set_' prefix to distinguish getters and setters
  # Using the exact same name seems to confuse the Opal compiler,
  # as does differentiating using '='
  def self.set_target_element_matcher(matcher)
    @rs_widget_state[KEY_DEFAULTS][KEY_TARGET_ELEMENT_MATCHER] = matcher
  end

  def self.template_element_matcher
    @rs_widget_state[KEY_DEFAULTS][KEY_TEMPLATE_ELEMENT_MATCHER]
  end
  
  def self.template_element_matcher=(matcher)
    @rs_widget_state[KEY_DEFAULTS][KEY_TEMPLATE_ELEMENT_MATCHER] = matcher
  end
end