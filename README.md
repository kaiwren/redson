# Redson

Redson is a lightweight client side MVC framework written in Ruby specifically for Rails applications. It uses the Opal Ruby to js compiler.

It builds on top of jQuery's proven cross-platform implementations of async http calls, DOM lookup+manipulation and the observer pattern to ensure compatibility and performance.

It's pretty much an experiment at the moment.


Here's what it looks like at the moment. WIP etc.

```ruby

    class Echo < Redson::Widget
      target_element_matcher '#greeter'
      bind '.input', :to => 'input', :update_on => 'keyup', :notify => :input_changed_handler

      def initialize(target_element)
        super(target_element)
        @output_element = @this_element.find!(".output")
      end

      def input_changed_handler(event)
        @output_element.text(@bound_values['input'])
      end
    end
```