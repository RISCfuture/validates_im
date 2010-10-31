require 'rake'
begin
  require 'bundler'
rescue LoadError
  puts "Bundler is not installed; install with `gem install bundler`."
  exit 1
end

Bundler.require :default

Jeweler::Tasks.new do |gem|
  gem.name = "validates_im"
  gem.summary = %Q{A set of Rails validators for common instant messenging services}
  gem.description = %Q{Adds ActiveModel validators for common instant messenging services like Skype and AIM.}
  gem.email = "git@timothymorgan.info"
  gem.homepage = "http://github.com/riscfuture/validates_im"
  gem.authors = [ "Tim Morgan" ]
  gem.add_dependency 'activerecord', '>= 3.0'
end
Jeweler::GemcutterTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

YARD::Rake::YardocTask.new('doc') do |doc|
  doc.options << "-m" << "textile"
  doc.options << "--protected"
  doc.options << "-r" << "README.textile"
  doc.options << "-o" << "doc"
  doc.options << "--title" << "validates_im Documentation".inspect
  
  doc.files = [ 'lib/*_validator.rb', 'README.textile' ]
end

task(default: :spec)
