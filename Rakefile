require "bundler"
require "rspec/core/rake_task"
Bundler.require

RSpec::Core::RakeTask.new

namespace :build do
  desc "Build our app to build.js"
  task :lib do
    Opal::Processor.source_map_enabled = false
    env = Opal::Environment.new
    env.append_path "lib"
  
    File.open("public/out/opal001.js", "w+") do |out|
      out << env["opal001"].to_s
    end
  end

  task :app do
    Opal::Processor.source_map_enabled = false
    env = Opal::Environment.new
    env.append_path "app"
  
    File.open("public/out/hello.js", "w+") do |out|
      out << env["hello"].to_s
    end
  end
end

desc "open the demo page in a browser"
task :launch do
  `open public/index.html`
end

desc "guard task"
task :build => ["build:lib", "build:app"]

task :default => ["build:lib", "build:app"]