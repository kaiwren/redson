# Redson

Redson is an opinionated client side component framework for Ruby on Rails applications. 

It is written in Ruby using the Opal Ruby to Javascript compiler.

Goals:

* Write client side (browser) code in Ruby
* Keep client side code organized, readable and maintainable
  * Use MV* pattern
  * Use Observer pattern
  * Make Widgets composable
  * Handle conventional CRUD Rails API calls using conventions
* Make developing and debugging when using observers easy
* Make writing tests easy

Redson is currently in alpha and under active development. Here are some examples of what it looks like at the moment.

## Decorate mode: Make simple HTML smarter

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

## Decorate mode: Make forms ajax and smarter

_Under app/assets/javascripts in your Rails app_
```ruby
module Student
  class Widget < Redson::Form::Widget
    disable_template!
    
    bind "input[name='student[name]']", :to => 'student[name]', :notify_on => 'keyup', :notification_handler => :student_name_keyup_handler
    bind "input[name='student[age]']", :to => 'student[age]', :notify_on => 'keyup', :notification_handler => :student_age_keyup_handler
  end
  
  class View < Redson::Form::View
    # Ajax handlers 
    # Allows your view to respond to ajax related
    # events on the model. Use them to show and 
    # hide spinners and so on.
    def request_started_handler(event);end
    def request_ended_handler(event);end
    
    # State handlers 
    # Allows your view to respond to state change
    # events on the model.
    def model_created_handler(event);end
    def model_updated_handler(event);end
    def model_unprocessable_entity_handler(event);end
    
    # Binding handlers
    # Allows your view to perform additional actions
    # after a view change updates a model attribute.
    def student_name_keyup_handler(event);end
    def student_age_keyup_handler(event);end
  end
  
  class Model < Redson::Form::Model
  end
end
```

```ruby
class StudentsController < ApplicationController
  ...
  
  # POST /students
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render json: @student, status: :created, location: student_url(@student) }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end
  
  ...
end
```

_A typical new.html.erb_

```css
form .activity_indicator {
  display: none;
}

form.busy .activity_indicator {
  display: inline;
}
```

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
    <img src="/assets/spinner.gif" class="activity_indicator" alt="Spinner">
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

## Getting Started

#### Setup

* Add this to the Gemfile at the root of your Rails app and bundle update
    
        gem 'opal-rails'
        gem 'redson', :git => "https://github.com/kaiwren/redson.git"
* Add this to `application.js` before `//= require_tree .`
        
        //= require opal
        //= require opal_ujs
        //= require redson
* Write Ruby code under app/assets/javascripts with a `.js.rb` or `.rb` file extension
* See the [sample app](rails-app/app/assests/javascripts) for examples of widgets

#### Debugging

Writing <code>\`debugger\`</code> anywhere in your client side Ruby code will set a breakpoint and trigger the browsers js debugger.

All event/observer wiring is logged to browser console to make development and debugging easy. This is opt-in - you'll need to turn it on if you need it.

```ruby
Redson.enable_logger!                       # Logs at severity DEBUG by
                                            # default. 
                                            # Use to track both event wiring
                                            # and dispatch.

Redson.enable_logger!(Redson::Logger::INFO) # Logs at severity INFO. 
                                            # Use to track only event dispatch.

Redson.disable_logger!                      # Switches to a NullLogger. 
                                            # This is the default.

Redson.l                                    # Get a reference to the logger.
Redson.l.d('message')                       # Log 'message' at DEBUG severity.

```

## Contributing to Redson

### Running Specs

Setup and launch the sample rails app. Specs run at /opal_spec

### Performance Benchmarks

Setup and launch the sample rails app. Specs run at /benchmarks and output is logged to the console. The page remains blank. This is normal.
