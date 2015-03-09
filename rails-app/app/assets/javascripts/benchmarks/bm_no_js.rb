module Benchmarks
  def self.fact(n)
    if (n > 1)
      n * fact(n-1)
    else
      1
    end
  end
  
  def self.fib(n)
    n < 2 ? n : fib(n - 1) + fib(n - 2)
  end
end