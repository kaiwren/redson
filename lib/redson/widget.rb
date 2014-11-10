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
  KEY_VIEW_KLASS_NAME = 'view_klass_name'
  KEY_MODEL_KLASS_NAME = 'model_klass_name'
  
  def self.inherited(base_klass)
    base_klass.initialize_widget_klass
  end
  
  def initialize(target_element = nil)
    @view = view_klass.new(
              target_element || Element.find!(target_element_matcher),
              Element.find!(template_element_matcher)
              )
    @bound_values = {}
    setup_bindings
  end
  
  def setup_bindings
    self.class.bindings.each do |binding|
      binding.create_for(self)
    end
  end
  
  def bind(element_matcher, to, event_name_to_update_on, notify)
    element = view.this_element.find!(element_matcher)
    element.on(event_name_to_update_on) do |event|
      @bound_values[to] = element.value
      self.method(notify).call(event)
    end
  end
    
  def render
    view.render
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
  
  def view_klass
    self.class.view_klass
  end
  
  def view
    @view
  end
  
  def self.instantiate_all_in_document
    widgets = []
    Element.find(target_element_matcher).each do |target|
      widgets << self.new(target)
    end
    widgets
  end
  
  def self.initialize_widget_klass
    @rs_widget_state = {}
    @rs_widget_state[KEY_DEFAULTS] = {}
    @rs_widget_state[KEY_BINDINGS] = []
    @rs_widget_state[KEY_WIDGET_NAME] = self.name.split(/::/)[-2].downcase
    @rs_widget_state[KEY_DEFAULTS][KEY_TEMPLATE_ELEMENT_MATCHER] = "#{TEMPLATE_ELEMENT_MATCHER}.#{widget_name}"
    @rs_widget_state[KEY_DEFAULTS][KEY_VIEW_KLASS_NAME] = "#{self.name}".sub("::Widget", "::View")
    @rs_widget_state[KEY_DEFAULTS][KEY_MODEL_KLASS_NAME] = "#{self.name}".sub("::Widget", "Model")
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
  
  # TODO
  # We're using the 'set_' prefix to distinguish getters and setters
  # Using the exact same name but different arity seems to confuse 
  # the Opal compiler, as does differentiating using '='
  def self.set_target_element_matcher(matcher)
    @rs_widget_state[KEY_DEFAULTS][KEY_TARGET_ELEMENT_MATCHER] = matcher
  end

  def self.template_element_matcher
    @rs_widget_state[KEY_DEFAULTS][KEY_TEMPLATE_ELEMENT_MATCHER]
  end
  
  def self.set_template_element_matcher(matcher)
    @rs_widget_state[KEY_DEFAULTS][KEY_TEMPLATE_ELEMENT_MATCHER] = matcher
  end
    
  def self.set_view_klass(klass)
    @rs_widget_state[KEY_DEFAULTS][KEY_VIEW_KLASS_NAME] = klass
  end
  
  def self.view_klass
    # TODO
    # Because Kernel.const_get("Foo::Bar::View") doesn't work on Opal
    @view_klass ||= @rs_widget_state[KEY_DEFAULTS][KEY_VIEW_KLASS_NAME].split(
    "::").inject(Kernel) do |const, name| 
      const.const_get(name)
    end
  end
end