# Redson

Redson is an opininated client side MVsomething (I can't keep up with all the MV* variations these days :P) component framework. 

Redson is written in Ruby specifically for Rails applications. It uses the Opal Ruby to js compiler to make client side Ruby possible.

Here's what it looks like at the moment. WIP etc.

## Adding a little smartness to HTML

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

## Making a form smarter using the Redson::Form Widget

_In your HTML view, usually new.html.erb_

```xml
<form accept-charset="UTF-8" action="/students" class="new_student" id="new_student" method="post"><div style="display:none"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="VaRmf+SWll5NSJPggOQ2I2zYMxYGEP53HBdTzzLjIMw=" /></div>

  <div class="field">
    <label for="student_name">Name</label><br>
    <input id="student_name" name="student[name]" type="text" />
  </div>
  <div class="field">
    <label for="student_age">Age</label><br>
    <input id="student_age" name="student[age]" type="text" />
  </div>
  <div class="actions">
    <input name="commit" type="submit" value="Create Student" />
  </div>
</form>

<a href="/students">Back</a>

```

```javascript
<script type="text/javascript">
  $(document).ready(function(){
    var widget = Opal.Student.Widget.$new($('form.new_student'));
    widget.$registerObserver({
        widget_created_handler: function(redsonEvent){
          window.location.href = redsonEvent.location();
        }
      },
      { on: 'created' }
    );
  });
</script>
```

_Under app/assets/javascripts in your Rails app_
```ruby
module Student
  class Widget < Redson::Form::Widget
    disable_template!
    
    bind "input[name='student[name]']", :to => 'student[name]', :notify_on => 'keyup', :notification_handler => :student_name_keyup_handler
    bind "input[name='student[age]']", :to => 'student[age]', :notify_on => 'keyup', :notification_handler => :student_age_keyup_handler
  end
  
  class View < Redson::Form::View
    def model_created_handler(event)
    end

    def model_updated_handler(event)
    end

    def model_unprocessable_entity_handler(event)
    end
  
    def student_name_keyup_handler(event)
    end
  
    def student_age_keyup_handler(event)
    end
  end
  
  class Model < Redson::Form::Model
  end
end
```

## Running Specs

Setup and launch the sample rails app. Specs run at /opal_spec

## Performance Benchmarks

Setup and launch the sample rails app. Specs run at /benchmarks and output is logged to the console. The page remains blank. This is normal.