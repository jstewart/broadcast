require "rake/testtask"
 
desc "Default: run tests"
task :default => :test
 
desc "Run tests"
task :test => ['test:units']
namespace :test do
  desc "Run unit tests"
  Rake::TestTask.new(:units) do |t|
    t.test_files = FileList["test/unit/**/*_test.rb"]
  end
end
