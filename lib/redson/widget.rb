class Redson::Widget
  TEMPLATES_ELEMENT_MATCHER = "#r-templates"
  TEMPLATE_ELEMENT_MATCHER = ".r-template"
  DEFAULTS = 'defaults'
  
  def self.inherited(base_klass)
    base_klass.class_eval do
      initialize_widget_klass
    end
  end
  
  def self.initialize_widget_klass
    @rs_widget_state = {}
    @rs_widget_state[DEFAULTS] = {}
    @rs_widget_state['widget_name'] = self.name.split(/::/).last.downcase
    @rs_widget_state[DEFAULTS]['template_element_matcher'] = "#{TEMPLATE_ELEMENT_MATCHER}.#{widget_name}"
  end
    
  def initialize(target_element)
    p 111
    @target_element = target_element
    @template_element = Element.find!(template_element_matcher)
    p template_element
    @this_element = template_element.clone
    p 222
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
  
  def self.widget_name
    @rs_widget_state['widget_name']
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