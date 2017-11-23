require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module SpecSupport
  class TestAccountNameValidator < AccountNameValidator; end
  class FakeModel
    extend ActiveModel::Translation
    extend ActiveModel::Naming
    def errors() @errors ||= ActiveModel::Errors.new(self) end
    def self.lookup_ancestors() [ self ] end
    def read_attribute_for_validation(_) "mock" end
  end
end

RSpec.describe AccountNameValidator do
  before :each do
    SpecSupport::TestAccountNameValidator.validations.clear
    @model = SpecSupport::FakeModel.new
  end

  describe ".error_key_prefix" do
    it "should be the downcased name of the validator by default" do
      expect(SpecSupport::TestAccountNameValidator.error_key_prefix).to eql(:test_account_name)
    end

    it "should be able to be set" do
      SpecSupport::TestAccountNameValidator.error_key_prefix(:foo)
      expect(SpecSupport::TestAccountNameValidator.error_key_prefix).to eql(:foo)
      SpecSupport::TestAccountNameValidator.instance_variable_set :@error_key_prefix, nil
    end
  end

  describe "#validate_each" do
    it "should do nothing if given nil and :allow_nil is set" do
      SpecSupport::TestAccountNameValidator.new(attributes: :field, allow_nil: true).validate_each(@model, :field, nil)
      expect(@model.errors).to be_empty
    end

    it "should do nothing if given a blank value and :allow_blank is set" do
      SpecSupport::TestAccountNameValidator.new(attributes: :field, allow_blank: true).validate_each(@model, :field, "")
      expect(@model.errors).to be_empty
    end

    it "should add an error to the record if any validation fails" do
      SpecSupport::TestAccountNameValidator.add_validation(:not_foo) { |value| value == 'foo' }
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, 'bar')
      expect(@model.errors[:field]).not_to be_empty
      expect(@model.errors[:field].first).to include('test_account_name_not_foo')
    end

    it "should use a :message option for the message" do
      SpecSupport::TestAccountNameValidator.add_validation(:not_foo) { |value| value == 'foo' }
      SpecSupport::TestAccountNameValidator.new(attributes: :field, message: 'bar').validate_each(@model, :field, 'bar')
      expect(@model.errors[:field]).to eql([ 'bar' ])
    end
    
    it "should typecast the value to a string" do
      SpecSupport::TestAccountNameValidator.add_validation(:not_foo) { |value| value == 'foo' }
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, :foo)
      expect(@model.errors).to be_empty
    end
  end

  describe ".add_validation" do
    before :each do
      @validator = SpecSupport::TestAccountNameValidator.new(attributes: :field)
    end

    it "should add a validation block" do
      SpecSupport::TestAccountNameValidator.add_validation(:not_foo) { |value| value == 'foo' }
      @validator.validate_each(@model, :field, 'bar')
      expect(@model.errors[:field]).not_to be_empty
    end

    it "should do nothing if no block is given" do
      SpecSupport::TestAccountNameValidator.add_validation(:not_foo)
      @validator.validate_each(@model, :field, 'bar')
      expect(@model.errors[:field]).to be_empty
    end
  end

  describe ".min_length" do
    it "should ensure a minimum length" do
      SpecSupport::TestAccountNameValidator.min_length 5
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, '1234')
      expect(@model.errors[:field]).not_to be_empty
      expect(@model.errors[:field].first).to include('too_short')
    end
  end

  describe ".max_length" do
    it "should ensure a maximum length" do
      SpecSupport::TestAccountNameValidator.max_length 5
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, '123456')
      expect(@model.errors[:field]).not_to be_empty
      expect(@model.errors[:field].first).to include('too_long')
    end
  end

  describe ".valid_chars" do
    it "should check for invalid chars" do
      SpecSupport::TestAccountNameValidator.valid_chars '[A-Z]'
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, 'A!Z')
      expect(@model.errors[:field]).not_to be_empty
      expect(@model.errors[:field].first).to include('invalid_chars')
    end
  end

  describe ".first_char" do
    it "should check for an invalid first character" do
      SpecSupport::TestAccountNameValidator.first_char '[A-Z]'
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, 'abc')
      expect(@model.errors[:field]).not_to be_empty
      expect(@model.errors[:field].first).to include('invalid_first_char')
    end
  end
end
