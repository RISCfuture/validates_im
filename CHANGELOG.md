# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-05-14

### Added
- `DiscordValidator` (`discord: true`) — modern Discord usernames (2-32 chars,
  `a-z0-9._`, no leading/trailing or consecutive periods, no discriminator).
- `TelegramValidator` (`telegram: true`) — 5-32 chars, alphanumeric + underscore,
  must start with a letter, cannot end with `_`. Optional leading `@` is stripped.
- `MatrixValidator` (`matrix: true`) — full Matrix user ID syntax
  (`@localpart:domain.tld`) per the current Matrix specification; max 255 chars.
- `SignalValidator` (`signal: true`) — Signal usernames (2024+), of the form
  `<base>.<digits>` with a 2+ digit discriminator.
- `min_length 3` / `max_length 12` on `XboxLiveValidator` so empty / overlong
  gamertags now produce sensible errors instead of crashing on `nil[0]`.
- Modern, hand-written gemspec with `rubygems_mfa_required` metadata.
- `lib/validates_im/version.rb` exposing `ValidatesIm::VERSION`.
- GitHub Actions matrix CI across Ruby 3.1-3.4 and ActiveModel 7.0-8.0.

### Changed
- Validator regex anchors use `\A` and `\z` instead of `^` and `$`, closing a
  multi-line bypass where an embedded newline would cause obviously-invalid
  values to pass.
- Bumped minimum supported Ruby to 3.1, minimum ActiveModel/ActiveSupport to 6.1.
- Replaced the activerecord runtime dependency with `activemodel` (and
  `activesupport`); the gem never required ActiveRecord.
- Replaced jeweler-driven packaging with a standard gemspec, `bin/console`,
  `bin/setup`, modern `Gemfile` / `Rakefile`.

### Fixed
- `lib/validates_im.rb` no longer self-requires itself in an infinite loop.
- Removed duplicate `add_dependency` entries (activerecord, rspec, yard, jeweler)
  and stale `README.textile` references in the gemspec.
- Gemfile now declares `redcarpet` consistently with the Rakefile's YARD setup
  (previous mismatch with `RedCloth` in the gemspec).

### Removed
- Jeweler-managed gemspec template / `VERSION` text file.
- The legacy `.travis.yml` and old `ruby.yml` workflow (superseded by `ci.yml`).

## [1.1.0]

Previous release. See git history.
