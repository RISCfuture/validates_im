# frozen_string_literal: true

# Validates Discord usernames using the modern (post-2023) username format.
# Discord eliminated the four-digit `#1234` discriminator system in 2023; usernames
# are now globally unique and use the rules below:
#
# * 2-32 characters long
# * Lowercase letters (`a`-`z`), digits (`0`-`9`), underscore (`_`), and period (`.`)
# * No consecutive periods (`..`)
# * Cannot start or end with a period
#
# The following error message keys are used to localize invalid usernames:
#
# |                              |                                                         |
# |:-----------------------------|:--------------------------------------------------------|
# | `discord_too_short`          | Username is less than 2 characters.                     |
# | `discord_too_long`           | Username is over 32 characters.                         |
# | `discord_invalid_chars`      | Username contains characters outside `[a-z0-9._]`.      |
# | `discord_invalid_format`     | Username has consecutive periods or starts/ends with a period. |
#
# @example
#   validates :discord, discord: true
#
# Options
# -------
#
# |              |                                                  |
# |:-------------|:-------------------------------------------------|
# | `:message`   | A custom message to use if the username is invalid. |
# | `:allow_nil` | If true, `nil` values are allowed.               |

class DiscordValidator < AccountNameValidator
  min_length 2
  max_length 32
  valid_chars "a-z0-9._"
  add_validation(:invalid_format) do |value|
    !value.include?("..") && !value.start_with?(".") && !value.end_with?(".")
  end
end
