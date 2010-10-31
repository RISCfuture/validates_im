# Validates Yahoo! Instant Messenger screen names. According to the Yahoo!
# website:
#
# bq. Use 4 to 32 characters and start with a letter. You may use letters,
# numbers, underscores, and one dot (.).
#
# The following error message keys are used to localize invalid screen names:
#
# | @yim_too_short@ | Screen name is less than 3 characters. |
# | @yim_too_long@ | Screen name is over 16 characters. |
# | @yim_invalid_chars@ | Screen name contains invalid characters. |
# | @yim_invalid_first_char@ | Screen name doesn't start with a letter. |
# | @yim_multiple_periods@ | Screen name has more than one period in it. |
#
# @example
#   validates :yim_sn, yahoo_im: true
#
# h2. Options
#
# | @:message@ | A custom message to use if the email is invalid. |
# | @:allow_nil@ | If true, @nil@ values are allowed. |

class YahooImValidator < AccountNameValidator
  error_key_prefix 'yim'
  min_length 4
  max_length 32
  valid_chars 'A-Za-z0-9_\\.'
  first_char 'A-Za-z'
  add_validation(:multiple_periods) { |value| value.count('.') < 2 }
end
