# Redson

Redson is a lightweight client side MVsomething (I can't keep up with all the MV* variations these days :P) component framework written in Ruby specifically for Rails applications. It uses the Opal Ruby to js compiler, and is an expression of my taste in UI frameworks developed over the years that I've been muddling around in the space.

It builds on top of jQuery's cross-platform implementations of DOM lookup+manipulation and the observer pattern to ensure compatibility and performance.

I'm developing against a sample rails app, so you can look under rails-app/assets/javascripts for examples.

I'm not sure this can be production capable anytime for several reasons, including the viability of my MV* approach and potential performance issues in compiled js as a consequence of said approach. We'll see.

Here's what it looks like at the moment. WIP etc.

_In your HTML view_
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

_Under app/assets/javascripts in your Rails app_
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

## Running Specs

Setup and launch the sample rails app. Specs run at /opal_spec

## Performance Benchmarks

Setup and launch the sample rails app. Specs run at /benchmarks and output is logged to the console. The page remains blank. This is normal.