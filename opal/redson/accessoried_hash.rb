module Redson
  # Like OpenStruct, but with real accessor methods
  class AccessoriedHash
    def initialize(hash)
      @hash = hash
      hash.each do |key, value|
        %x{
          if(typeof value === 'function') {
            def['$'+key] = value;
          } 
          else{
            def['$'+key] = function(){
              return #@hash[key];
            };
          }
        }
      end
    end
  end
end