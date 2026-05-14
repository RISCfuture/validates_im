# frozen_string_literal: true

require "active_model"

module SpecSupport
  # Bare-minimum ActiveModel-compatible target for `EachValidator#validate_each`.
  class FakeModel
    extend ActiveModel::Translation
    extend ActiveModel::Naming

    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end

    def self.lookup_ancestors
      [self]
    end

    def read_attribute_for_validation(_attr)
      "mock"
    end
  end
end
