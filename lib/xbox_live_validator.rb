# Validates Xbox Live gamertags. From the Xbox Live website:
#
# > Gamertags can only contain letters, numbers, and spaces, and can't begin
# > with a number.
#
# In addition we discovered that they have no minimum length but are no more
# than 15 characters, and also cannot start with a space.
#
# The following error message keys are used to localize invalid screen names.
#
# |                           |                                       |
# |:--------------------------|:--------------------------------------|
# | `xbox_too_long`           | Gamertag is over 15 characters.       |
# | `xbox_invalid_chars`      | Gamertag contains invalid characters. |
# | `xbox_invalid_first_char` | Gamertag doesn't start with a letter. |
#
# @example
#   validates :steam_account, steam: true
#
# Options
# -------
#
# |              |                                                  |
# |:-------------|:-------------------------------------------------|
# | `:message`   | A custom message to use if the email is invalid. |
# | `:allow_nil` | If true, `nil` values are allowed.               |

class XboxLiveValidator < AccountNameValidator
  error_key_prefix 'xbox'
  max_length 15
  valid_chars 'A-Za-z0-9 '
  first_char 'A-Za-z'
end
