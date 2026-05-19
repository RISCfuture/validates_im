# frozen_string_literal: true

# Validates Telegram usernames. Telegram usernames are 5-32 characters of
# alphanumerics and underscores; they must start with a letter and cannot end
# with an underscore. Username lookups are case-insensitive. A leading `@` is
# stripped before validation.
#
# The following error message keys are used to localize invalid usernames:
#
# |                                |                                                       |
# |:-------------------------------|:------------------------------------------------------|
# | `telegram_too_short`           | Username is less than 5 characters.                   |
# | `telegram_too_long`            | Username is over 32 characters.                       |
# | `telegram_invalid_chars`       | Username contains characters outside `[A-Za-z0-9_]`.  |
# | `telegram_invalid_first_char`  | Username doesn't start with a letter.                 |
# | `telegram_trailing_underscore` | Username ends with an underscore.                     |
#
# @example
#   validates :telegram, telegram: true
#
# Options
# -------
#
# |              |                                                  |
# |:-------------|:-------------------------------------------------|
# | `:message`   | A custom message to use if the username is invalid. |
# | `:allow_nil` | If true, `nil` values are allowed.               |

class TelegramValidator < AccountNameValidator
  min_length 5
  max_length 32
  valid_chars "A-Za-z0-9_"
  first_char "A-Za-z"
  add_validation(:trailing_underscore) { |value| !value.end_with?("_") }

  # Overrides {AccountNameValidator#validate_each} to strip an optional leading
  # `@` before applying validations.
  def validate_each(record, attribute, value)
    if value.kind_of?(String) && value.start_with?("@")
      value = value[1..]
    end
    super
  end
end
