# Validates AOL Instant Messenger screen names. According to the AOL website:
#
# bq. 3-16 letters or numbers. It must start with a letter.
#
# The following error message keys are used to localize invalid screen names:
#
# | @aim_too_short@ | Screen name is less than 3 characters. |
# | @aim_too_long@ | Screen name is over 16 characters. |
# | @aim_invalid_chars@ | Screen name contains invalid characters. |
# | @aim_invalid_first_char@ | Screen name doesn't start with a letter. |
#
# @example
#   validates :aim_screen_name, aim: true
#
# h2. Options
#
# | @:message@ | A custom message to use if the email is invalid. |
# | @:allow_nil@ | If true, @nil@ values are allowed. |

class AimValidator < AccountNameValidator
  min_length 3
  max_length 16
  valid_chars 'A-Za-z0-9'
  first_char 'A-Za-z'
end
