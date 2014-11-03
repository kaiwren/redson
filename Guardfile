# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{public/.+\.(css|js|html)})
end

guard 'rake', :task => 'build' do
  watch(%r{app/.+\.(rb|js)$})
  watch(%r{lib/.+\.(rb|js)$})
end
