# Add Redson spec dir to Opal's load path so that we can require spec_helper.rb
Opal.append_path File.join(File.dirname(File.expand_path(__FILE__)), '..', '..', '..', 'spec')