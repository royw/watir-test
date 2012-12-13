
require 'rspec'
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ["-c", "-f progress"] #, "-r ./spec/spec_helper.rb"]
  spec.pattern = FileList["spec/**/*_spec.rb"]
end

