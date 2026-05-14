# frozen_string_literal: true

require_relative "lib/validates_im/version"

Gem::Specification.new do |spec|
  spec.name          = "validates_im"
  spec.version       = ValidatesIm::VERSION
  spec.authors       = ["Tim Morgan"]
  spec.email         = "git@timothymorgan.info"

  spec.summary       = "A set of Rails validators for common instant messaging services"
  spec.description   = "Adds ActiveModel validators for common instant messaging services like Discord, Telegram, Matrix, and Signal (as well as legacy services like AIM, Yahoo!, and Skype)."
  spec.homepage      = "https://github.com/riscfuture/validates_im"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.1"

  spec.metadata = {
    "homepage_uri"          => spec.homepage,
    "source_code_uri"       => "#{spec.homepage}/tree/master",
    "changelog_uri"         => "#{spec.homepage}/blob/master/CHANGELOG.md",
    "bug_tracker_uri"       => "#{spec.homepage}/issues",
    "rubygems_mfa_required" => "true"
  }

  spec.files = Dir.chdir(__dir__) do
    candidates =
      if system("git rev-parse --is-inside-work-tree > /dev/null 2>&1")
        `git ls-files -z`.split("\x0").reject do |f|
          f.start_with?(".github/", "spec/", ".idea/", ".claude/", "bin/") ||
            f.match?(/\A(?:Gemfile|Gemfile\.lock|Rakefile|\.rspec|\.rubocop\.yml|\.travis\.yml|\.ruby-(?:gemset|version)|\.gitignore|\.document)/)
        end
      else
        Dir["lib/**/*.rb"] + %w[LICENSE README.md CHANGELOG.md validates_im.gemspec]
      end
    candidates.select { |f| File.exist?(f) } +
      Dir["lib/**/*.rb"].reject { |f| candidates.include?(f) } +
      %w[CHANGELOG.md].reject { |f| candidates.include?(f) || !File.exist?(f) }
  end.uniq

  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel",   ">= 6.1"
  spec.add_dependency "activesupport", ">= 6.1"
end
