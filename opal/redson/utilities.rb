module Redson
  module Utilities
    def js_object_to_rb_hash(object)
      %x{
        if(typeof object === 'object' && object.$class === undefined){
          Opal.Redson.$l().$d("Object " + JSON.stringify(object) + " identified as js Object, converting to rb Hash");
          object = Opal.hash(object);
        }
        return object;
      }
    end
  end
  extend Utilities
end