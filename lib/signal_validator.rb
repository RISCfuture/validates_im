# frozen_string_literal: true

# Validates Signal usernames. Signal introduced usernames in 2024; they consist
# of a base name and a numeric discriminator separated by a period:
#
#   <base>.<digits>
#
# * Base: starts with a letter, contains letters, digits, and underscores.
# * Discriminator: two or more digits (leading zeros allowed, e.g. `0123`).
# * Combined length 3-32 characters (matching Signal's UI constraints).
#
# The following error message keys are used to localize invalid usernames:
#
# |                              |                                                                |
# |:-----------------------------|:---------------------------------------------------------------|
# | `signal_too_short`           | Username is less than 3 characters.                            |
# | `signal_too_long`            | Username is over 32 characters.                                |
# | `signal_invalid_format`      | Username doesn't match `<base>.<digits>` with a valid base.    |
#
# @example
#   validates :signal_username, signal: true
#
# Options
# -------
#
# |              |                                                  |
# |:-------------|:-------------------------------------------------|
# | `:message`   | A custom message to use if the username is invalid. |
# | `:allow_nil` | If true, `nil` values are allowed.               |

class SignalValidator < AccountNameValidator
  FORMAT = /\A[A-Za-z][A-Za-z0-9_]*\.\d{2,}\z/.freeze

  min_length 3
  max_length 32
  add_validation(:invalid_format) { |value| value.match?(FORMAT) }
end
