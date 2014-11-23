var JS = JS || {};
JS.Benchmarks = JS.Benchmarks || {};

JS.Benchmarks.fact = function(n){
  if(n > 1) {
    return n * this.fact(n-1);
  }
  else {
    return 1;
  }
}