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
  KEY_USE_TEMPLATE = 'use_template'
  
  include Redson::Observable
  
  attr_reader :view, :model
  
  def self.inherited(base_klass)
    base_klass.initialize_widget_klass
  end
  
  def initialize(target_element = nil)
    raise Redson::Error::NotADomElementError.new(target_element) unless target_element.class == Element
    @model = model_klass.new
    @view = view_klass.new(
              @model,
              target_element || Element.find!(target_element_matcher),
              using_template? ? Element.find!(template_element_matcher) : nil
              )
    setup_bindings
    initialize_observable
  end
  
  def setup_bindings
    self.class.bindings.each do |binding|
      binding.create_for(self)
    end
  end
  
  def bind(element_matcher, to, event_name_to_update_on, notification_handler)
    view.bind(element_matcher, to, event_name_to_update_on, notification_handler)
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

  def using_template?
    self.class.using_template?
  end
  
  def view_klass
    self.class.view_klass
  end

  def model_klass
    self.class.model_klass
  end
  
  def self.instantiate_all_in_document
    widgets = []
    Element.find(target_element_matcher).each do |target|
      widgets << self.new(target)
    end
    widgets
  end
  
  def self.render_all_in_document
    instantiate_all_in_document.each do |widget|
      widget.render
    end
  end
  
  def self.initialize_widget_klass
    @_redson_widget_config = {}
    @_redson_widget_config[KEY_DEFAULTS] = {}
    @_redson_widget_config[KEY_BINDINGS] = []
    @_redson_widget_config[KEY_WIDGET_NAME] = self.name.split(/::/)[-2].downcase
    @_redson_widget_config[KEY_DEFAULTS][KEY_USE_TEMPLATE] = true
    @_redson_widget_config[KEY_DEFAULTS][KEY_TEMPLATE_ELEMENT_MATCHER] = "#{TEMPLATE_ELEMENT_MATCHER}.#{widget_name}"
    @_redson_widget_config[KEY_DEFAULTS][KEY_VIEW_KLASS_NAME] = "#{self.name}".sub("::Widget", "::View")
    @_redson_widget_config[KEY_DEFAULTS][KEY_MODEL_KLASS_NAME] = "#{self.name}".sub("::Widget", "::Model")
  end
  
  def self.bind(element_matcher, options)
    @_redson_widget_config[KEY_BINDINGS] << Binding.new(element_matcher, options)
  end
  
  def self.widget_name
    @_redson_widget_config[KEY_WIDGET_NAME]
  end
  
  def self.bindings
    @_redson_widget_config[KEY_BINDINGS]
  end
    
  def self.target_element_matcher
    @_redson_widget_config[KEY_DEFAULTS][KEY_TARGET_ELEMENT_MATCHER]
  end
  
  # TODO
  # We're using the 'set_' prefix to distinguish getters and setters
  # Using the exact same name but different arity seems to confuse 
  # the Opal compiler, as does differentiating using '='
  def self.set_target_element_matcher(matcher)
    @_redson_widget_config[KEY_DEFAULTS][KEY_TARGET_ELEMENT_MATCHER] = matcher
  end

  def self.template_element_matcher
    @_redson_widget_config[KEY_DEFAULTS][KEY_TEMPLATE_ELEMENT_MATCHER]
  end
  
  def self.set_template_element_matcher(matcher)
    @_redson_widget_config[KEY_DEFAULTS][KEY_TEMPLATE_ELEMENT_MATCHER] = matcher
  end

  def self.disable_template!
    @_redson_widget_config[KEY_DEFAULTS][KEY_USE_TEMPLATE] = false
  end
  
  def self.using_template?
    @_redson_widget_config[KEY_DEFAULTS][KEY_USE_TEMPLATE]
  end
        
  def self.view_klass
    # TODO
    # Because Kernel.const_get("Foo::Bar::View") doesn't work on Opal
    @view_klass ||= load_fully_qualified_constant(@_redson_widget_config[KEY_DEFAULTS][KEY_VIEW_KLASS_NAME])
  end
  
  def self.model_klass
    # TODO
    # Because Kernel.const_get("Foo::Bar::View") doesn't work on Opal
    @model_klass ||= load_fully_qualified_constant(@_redson_widget_config[KEY_DEFAULTS][KEY_MODEL_KLASS_NAME])
  end
  
  private
  def self.load_fully_qualified_constant(constant_string)
    constant_string.split("::").inject(Kernel) do |const, name| 
      const.const_get(name)
    end
  end
end