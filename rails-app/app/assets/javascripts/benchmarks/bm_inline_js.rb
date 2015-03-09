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
  
  def self.fib_inline_js(n)
    `return n < 2 ? n : this.$fib_inline_js(n - 1) + this.$fib_inline_js(n - 2);`
  end
end