class Redson::Form
  attr_reader :form_element
  def initialize(element)
    raise "#{element.inspect} is not a form element" unless element.is('form')
    @form_element = element
  end
  
  def ajaxify!(&block)
    form_element.on('submit', &block)
    disable_submit_event_propagation!
  end
  
  def disable_submit_event_propagation!
    form_element.on('submit') do |event|
      `event.native.preventDefault()`
    end
  end
    
  def action_attribute
    @form_element['action']
  end
  
  def submit_element
    form_element.find('input[type=submit]')
  end
  
  def input_elements
    form_element.find('input[type!=submit]')
  end
end