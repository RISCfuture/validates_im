# Validates steam account IDs. Steam IDs are between 3 and 63 characters long
# and consist of letters, numbers, or underscores.
#
# The following error message keys are used to localize invalid screen names.
#
# | @steam_too_short@ | Steam ID is less than 6 characters. |
# | @steam_too_long@ | Steam ID is over 32 characters. |
# | @steam_invalid_chars@ | Steam ID contains invalid characters. |
# | @steam_invalid_first_char@ | Steam ID doesn't start with a letter. |
#
# @example
#   validates :steam_id, steam: true

class SteamValidator < AccountNameValidator
  min_length 3
  max_length 63
  valid_chars 'A-Za-z0-9_'
end
