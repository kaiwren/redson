# Redson

Redson is a lightweight client side MVC framework written in Ruby specifically for Rails applications. It uses the Opal Ruby to js compiler.

It builds on top of jQuery's proven cross-platform implementations of async http calls, DOM lookup+manipulation and the observer pattern to ensure compatibility and performance.

It's pretty much an experiment at the moment.


Here's what it looks like at the moment. WIP etc.

```xml
<!DOCTYPE html>
<html>
  <head>
    <script src="lib/jquery.min.js"></script>
    <script src="out/redson.js"></script>
    <script src="out/hello.js"></script>
  </head>
  <body>
    <div id="echo"></div>
    <div id="r-templates" style="display: none;">
      <div class="r-template echo">
        <input class="input"/>
        <span class="output"/>
      </div>      
    </div>
  </body>
</html>
```

```ruby
class Hello::Echo < Redson::Widget
  set_target_element_matcher '#echo'
  bind '.input', :to => 'input', :update_on => 'keyup', :notify => :input_changed_handler

  def initialize
    @output_element = @this_element.find!(".output")
  end

  def input_changed_handler(event)
    @output_element.text(@bound_values['input'])
  end
end
```
