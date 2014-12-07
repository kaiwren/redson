module Redson
  # Use this to create event handlers
  # conveniently in js
  class EventHandler < OpenStruct
    def initialize(javascript_hash)
      puts javascript_hash.class 
      super
      ruby_hash = `Opal.hash(javascript_hash)`
    end
  end
end