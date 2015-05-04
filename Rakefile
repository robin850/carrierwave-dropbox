require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new("test_unit") do |t|
  t.libs << "test"
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.description = "Run the unit tests without loading .credentials.yml"
end

task :load_credentials do
  require 'yaml'

  path = File.expand_path("../.credentials.yml", __FILE__)
  hash = YAML.load(File.read(path))

  hash.each do |key, value|
    ENV[key.upcase] ||= value
  end
end

desc "Run the unit tests"
task test: [:load_credentials, :test_unit]

task default: :test
