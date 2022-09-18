require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name        = "validates_im"
  gem.summary     = %Q{A set of Rails validators for common instant messaging services}
  gem.description = %Q{Adds ActiveModel validators for common instant messaging services like Skype and AIM.}
  gem.email       = "git@timothymorgan.info"
  gem.homepage    = "http://github.com/riscfuture/validates_im"
  gem.authors     = ["Tim Morgan"]
  gem.add_dependency 'activerecord', '>= 3.0'
  gem.files = %w( lib/**/* validates_im.gemspec README.textile LICENSE )
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

require 'yard'

# bring sexy back (sexy == tables)
module YARD::Templates::Helpers::HtmlHelper
  def html_markup_markdown(text)
    markup_class(:markdown).new(text, :gh_blockcode, :fenced_code, :autolink, :tables, :no_intraemphasis).to_html
  end
end

YARD::Rake::YardocTask.new('doc') do |doc|
  doc.options << '-m' << 'markdown'
  doc.options << '-M' << 'redcarpet'
  doc.options << '--protected' << '--no-private'
  doc.options << '-r' << 'README.md'
  doc.options << '-o' << 'doc'
  doc.options << '--title' << 'validates_im Documentation'

  doc.files = %w(lib/*_validator.rb README.md)
end

task(default: :spec)
