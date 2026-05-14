validates_im
============

[![CI](https://github.com/RISCfuture/validates_im/actions/workflows/ci.yml/badge.svg)](https://github.com/RISCfuture/validates_im/actions/workflows/ci.yml)
[![Gem Version](https://img.shields.io/gem/v/validates_im.svg)](https://rubygems.org/gems/validates_im)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

**Instant messenger account validators for ActiveModel / Rails**

`validates_im` is a small gem that gives you a collection of
`ActiveModel::EachValidator`s for common instant-messaging and gaming-service
account names. Drop one onto an attribute and your model will reject malformed
account IDs at validation time.

Supported services
------------------

Modern services:

| Validator              | DSL key       | Description                                                                  |
|:-----------------------|:--------------|:-----------------------------------------------------------------------------|
| `DiscordValidator`     | `discord:`    | Discord usernames (post-2023 format, no discriminator)                       |
| `TelegramValidator`    | `telegram:`   | Telegram usernames (`@handle` style; leading `@` is stripped automatically)  |
| `MatrixValidator`      | `matrix:`     | Matrix IDs of the form `@localpart:domain.tld` per the Matrix specification  |
| `SignalValidator`      | `signal:`     | Signal usernames (`base.NN` with a 2+ digit discriminator)                   |
| `SteamValidator`       | `steam:`      | Steam account IDs                                                            |
| `XboxLiveValidator`    | `xbox_live:`  | Xbox Live gamertags                                                          |

Legacy services (kept for backwards compatibility; these services are largely
defunct):

| Validator             | DSL key      | Description                          |
|:----------------------|:-------------|:-------------------------------------|
| `AimValidator`        | `aim:`       | AOL Instant Messenger screen names   |
| `YahooImValidator`    | `yahoo_im:`  | Yahoo! Messenger screen names        |
| `SkypeValidator`      | `skype:`     | Skype account names                  |

Installation
------------

Add this line to your application's `Gemfile`:

```ruby
gem "validates_im"
```

And then execute:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install validates_im
```

Requires Ruby 3.1+ and ActiveModel 6.1+. The gem works in any project that uses
ActiveModel validations — Rails is not required, just ActiveModel.

Usage
-----

The validators are standard `EachValidator`s. Use them via `validates`:

```ruby
class Account < ApplicationRecord
  validates :discord_handle,  discord:   true, allow_blank: true
  validates :telegram_handle, telegram:  true, allow_blank: true
  validates :matrix_id,       matrix:    true, allow_blank: true
  validates :signal_username, signal:    true, allow_blank: true
  validates :steam_id,        steam:     true, allow_blank: true
  validates :xbox_gamertag,   xbox_live: true, allow_blank: true
end
```

The DSL key for a validator is its class name with the `Validator` suffix
stripped and underscored — so `XboxLiveValidator` becomes `xbox_live:`.

Each validator supports the usual `:allow_nil`, `:allow_blank`, and `:message`
options. Error messages are localized via Rails i18n; the localization keys are
documented in each validator's class comment.

Writing your own validator
--------------------------

`AccountNameValidator` provides a small DSL for declarative account-name
validators. To add a hypothetical "Talkalot" service:

```ruby
class TalkalotValidator < AccountNameValidator
  min_length 5
  max_length 64
  valid_chars "A-Za-z0-9_"
  first_char  "A-Za-z"

  add_validation(:no_double_underscore) { |value| !value.include?("__") }
end
```

For services whose IDs don't fit the simple "single account-name string" mould
(like Matrix's full `@user:server.tld` syntax), subclass
`ActiveModel::EachValidator` directly — see `MatrixValidator` for an example.

License
-------

MIT. See `LICENSE`.
