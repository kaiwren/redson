var JS = JS || {};
JS.Benchmarks = {
  fact: function(n){
    if(n > 1) {
      return n * this.fact(n-1);
    }
    else {
      return 1;
    }
  },
  
  fib: function(n){
    return n < 2 ? n : this.fib(n - 1) + this.fib(n - 2);
  }
};