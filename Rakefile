require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the request_stubber plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the request_stubber plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'RequestStubber'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "request_stubber"
    s.homepage = "http://github.com/Fingertips/request_stubber"
    s.email = "eloy.de.enige@gmail.com"
    s.authors = ["Eloy Duran"]
    s.summary = s.description = "A simple Rails plugin to delay responses or return specific response codes. (Needs a new name.)"
  end
rescue LoadError
end