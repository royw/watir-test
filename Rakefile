
require 'rspec'
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ["-c", "-f progress"] #, "-r ./spec/spec_helper.rb"]
  spec.pattern = FileList["spec/**/*_spec.rb"]
end

begin
  require 'yard'

  yard_output_dir = 'doc'

  desc 'Remove the generated documentation'
  task :clean do
    puts "removing yard documentation"
    FileUtils.rm_rf File.expand_path(yard_output_dir, Rake.application.original_dir)
    FileUtils.rm_rf File.expand_path('.yardoc', Rake.application.original_dir)
  end

  YARD::Rake::YardocTask.new do |t|
    files = []
    files += Dir["spec/**/*.rb"]

    t.files = files.uniq

    t.options = ['--title', "Spiceworks Community Tests".strip,
                 '--output-dir', yard_output_dir,
                 '--protected', '--private', '--embed-mixins',
                 '--markup', 'markdown',
                 '--files', Dir["*.md"].join(','),
                 '--readme', 'README.md']
  end

  require 'digest/md5'
  desc 'create ~/.yard/config'
  task :yard_config do
    FileUtils.mkdir_p File.expand_path('~/.yard')
    config_file = File.expand_path("~/.yard/config")
    config = SymbolHash.new
    config = YAML.load IO.read(config_file) if File.exist? config_file
    config_sha1 = Digest::MD5.hexdigest(config.to_s)
    config[:'load_plugins'] ||= true
    config[:'ignored_plugins'] ||= []
    config[:'autoload_plugins'] ||= []
    config[:'safe_mode'] ||= false
    unless config_sha1 == Digest::MD5.hexdigest(config.to_s)
      File.open(config_file, 'w') {|f| f.puts YAML.dump(config)}
    end
  end

  desc 'Generate Documentation from .md, .rb'
  task :doc => [:clean, :yard]
rescue LoadError
  warn "yard or erb not available, yard documentation tasks not provided."
end
