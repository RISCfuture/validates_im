# frozen_string_literal: true

# Validates Matrix user IDs in the form `@localpart:domain.tld` per the Matrix
# specification (https://spec.matrix.org/latest/appendices/#user-identifiers).
#
# * Begins with `@`.
# * Localpart consists of lowercase letters `a`-`z`, digits `0`-`9`, and any of
#   `-`, `_`, `.`, `=`, `/`, `+`.
# * `:` separator between the localpart and the server name (domain).
# * The server name is a hostname (with optional port).
# * The entire ID must be 255 characters or fewer.
#
# Historical Matrix IDs allowed additional characters in the localpart; this
# validator enforces the current ("grammar") rules from the spec.
#
# The following error message keys are used to localize invalid IDs:
#
# |                          |                                       |
# |:-------------------------|:--------------------------------------|
# | `matrix_too_long`        | ID is over 255 characters.            |
# | `matrix_invalid_format`  | ID does not match `@localpart:domain`. |
#
# @example
#   validates :matrix_id, matrix: true
#
# Options
# -------
#
# |              |                                                  |
# |:-------------|:-------------------------------------------------|
# | `:message`   | A custom message to use if the ID is invalid.    |
# | `:allow_nil` | If true, `nil` values are allowed.               |

class MatrixValidator < ActiveModel::EachValidator
  MAX_LENGTH = 255

  # Localpart per the Matrix spec, restricted to the documented character set.
  LOCALPART = %r{[a-z0-9._=/+\-]+}.freeze

  # A reasonably-strict hostname or IP literal, optionally followed by `:port`.
  HOSTNAME_LABEL = /[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?/.freeze
  HOSTNAME = /#{HOSTNAME_LABEL}(?:\.#{HOSTNAME_LABEL})*/.freeze
  IPV4 = /(?:\d{1,3}\.){3}\d{1,3}/.freeze
  IPV6 = /\[[0-9A-Fa-f:.]+\]/.freeze
  SERVERNAME = /(?:#{IPV6}|#{IPV4}|#{HOSTNAME})(?::\d{1,5})?/.freeze

  FORMAT = /\A@#{LOCALPART}:#{SERVERNAME}\z/.freeze

  def validate_each(record, attribute, value)
    return if options[:allow_nil] && value.nil?
    return if options[:allow_blank] && value.blank?

    str = value.to_s

    if str.length > MAX_LENGTH
      record.errors.add(attribute, options[:message] || record.errors.generate_message(attribute, :matrix_too_long))
    end

    unless str.match?(FORMAT)
      record.errors.add(attribute, options[:message] || record.errors.generate_message(attribute, :matrix_invalid_format))
    end
  end
end
