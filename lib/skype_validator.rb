# Validates Skype screen names. From the Skype website:
#
# bq. It must be between 6-32 characters, start with a letter and contain only
# letters and numbers (no spaces or special characters).
#
# The following error message keys are used to localize invalid screen names.
#
# | @skype_too_short@ | Skype name is less than 6 characters. |
# | @skype_too_long@ | Skype name is over 32 characters. |
# | @skype_invalid_chars@ | Skype name contains invalid characters. |
# | @skype_invalid_first_char@ | Skype name doesn't start with a letter. |
#
# @example
#   validates :skype_name, skype: true
#
# h2. Options
#
# | @:message@ | A custom message to use if the email is invalid. |
# | @:allow_nil@ | If true, @nil@ values are allowed. |

class SkypeValidator < AccountNameValidator
  min_length 6
  max_length 32
  valid_chars 'A-Za-z0-9'
  first_char 'A-Za-z'
end
