# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

# stub: validates_im 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "validates_im"
  s.version = "1.1.0"

  s.required_ruby_version = '>= 2.5'
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Morgan"]
  s.description = "Adds ActiveModel validators for common instant messaging services like Skype and AIM."
  s.email = "git@timothymorgan.info"
  s.extra_rdoc_files = %w[LICENSE README.textile]
  s.files = %w[LICENSE README.textile lib/account_name_validator.rb lib/aim_validator.rb lib/skype_validator.rb lib/steam_validator.rb lib/validates_im.rb lib/xbox_live_validator.rb lib/yahoo_im_validator.rb validates_im.gemspec]
  s.homepage = "https://github.com/riscfuture/validates_im"
  s.require_paths = %w[lib]
  s.rubygems_version = "2.1.11"
  s.summary = "A set of Rails validators for common instant messaging services"

  if s.respond_to? :specification_version
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0')
      s.add_runtime_dependency('activerecord', [">= 3.1"])
      s.add_development_dependency('jeweler', [">= 0"])
      s.add_development_dependency('RedCloth', [">= 0"])
      s.add_development_dependency('rspec', [">= 0"])
      s.add_development_dependency('yard', [">= 0"])
      s.add_dependency('activerecord', [">= 3.1"])
    else
      s.add_dependency('activerecord', [">= 3.1"])
      s.add_dependency('activerecord', [">= 3.0"])
      s.add_dependency('rspec', [">= 0"])
      s.add_dependency('rspec', [">= 0"])
      s.add_dependency('rspec', [">= 0"])
      s.add_dependency('yard', [">= 0"])
    end
  else
    s.add_dependency('jeweler', [">= 0"])
    s.add_dependency('jeweler', [">= 0"])
    s.add_dependency('RedCloth', [">= 0"])
    s.add_dependency('yard', [">= 0"])
    s.add_dependency('yard', [">= 0"])
    s.add_runtime_dependency('activerecord', [">= 3.0"])
  end
end
