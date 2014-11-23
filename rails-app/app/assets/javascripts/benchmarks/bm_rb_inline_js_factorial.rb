module Benchmarks
  def self.fact_inline_js(n)
    %x{
      if(n > 1) {
        return n * this.$fact_inline_js(n-1);
      }
      else {
        return 1;
      }
    }
  end
end