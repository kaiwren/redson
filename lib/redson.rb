require "opal"
require "opal-jquery"

# Register our library code path with opal build tools
# This allows opal-rails to pick us up
Opal.append_path File.join(File.dirname(File.expand_path(__FILE__)), '..', 'opal')