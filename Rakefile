require "opal"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new

desc "Build our app to build.js"
task :build do
  Opal::Processor.source_map_enabled = false
  env = Opal::Environment.new
  env.append_path "lib"

  File.open("public/build.js", "w+") do |out|
    out << env["opal001"].to_s
  end
end

desc "open the demo page in a browser"
task :launch do
  `open public/index.html`
end

task :default => [:spec, :build, :launch]