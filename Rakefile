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
    File.open("out/redson.js", "w+") do |out|
      out << env["redson"].to_s
    end
  end
end

desc "guard task"
task :build => ["build:lib"]

task :default => :build