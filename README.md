# Redson

Redson is a lightweight client side MVC component framework written in Ruby specifically for Rails applications. It uses the Opal Ruby to js compiler.

It builds on top of jQuery's proven cross-platform implementations of DOM lookup+manipulation and the observer pattern to ensure compatibility and performance.

I'm developing against a sample rails app, so you can look under rails-app/assets/javascripts for examples.

Here's what it looks like at the moment. WIP etc.

```xml
    <div id="echoes">
      <div class="echo"></div>
      <hr/>
      <div class="echo"></div>
    </div>
    <div id="r-templates" style="display: none;">
      <div class="r-template echo">
        <input class="input"/>
        <span class="output"/>
      </div>
    </div>
```

```javascript
  $(document).ready(function(){
    Opal.Echo.Widget.$render_all_in_document();
  });
```

```ruby
module Echo
  class Widget < Redson::Widget
    set_target_element_matcher '#echoes .echo'
    bind '.input', :to => 'input', :notify_on => 'keyup', :notification_handler => :input_keyup_handler    
  end
  
  class Model < Redson::Model
  end
  
  class View < Redson::View
    def initialize_view_elements
      @output_element = this_element.find!(".output")
    end
    
    def input_keyup_handler(event)
      @output_element.text(model['input'])
    end
  end
end
```
