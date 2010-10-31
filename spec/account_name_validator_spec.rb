require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module SpecSupport
  class TestAccountNameValidator < AccountNameValidator; end
  class FakeModel
    extend ActiveModel::Translation
    def errors() @errors ||= ActiveModel::Errors.new(self) end
    def self.lookup_ancestors() [ self ] end
    def read_attribute_for_validation(_) "mock" end
  end
end

describe AccountNameValidator do
  before :each do
    SpecSupport::TestAccountNameValidator.validations.clear
    @model = SpecSupport::FakeModel.new
  end

  describe ".error_key_prefix" do
    it "should be the downcased name of the validator by default" do
      SpecSupport::TestAccountNameValidator.error_key_prefix.should eql(:test_account_name)
    end

    it "should be able to be set" do
      SpecSupport::TestAccountNameValidator.error_key_prefix(:foo)
      SpecSupport::TestAccountNameValidator.error_key_prefix.should eql(:foo)
      SpecSupport::TestAccountNameValidator.instance_variable_set :@error_key_prefix, nil
    end
  end

  describe "#validate_each" do
    it "should do nothing if given nil and :allow_nil is set" do
      SpecSupport::TestAccountNameValidator.new(attributes: :field, allow_nil: true).validate_each(@model, :field, nil)
      @model.errors.should be_empty
    end

    it "should do nothing if given a blank value and :allow_blank is set" do
      SpecSupport::TestAccountNameValidator.new(attributes: :field, allow_blank: true).validate_each(@model, :field, "")
      @model.errors.should be_empty
    end

    it "should add an error to the record if any validation fails" do
      SpecSupport::TestAccountNameValidator.add_validation(:not_foo) { |value| value == 'foo' }
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, 'bar')
      @model.errors[:field].should_not be_empty
      @model.errors[:field].first.should include('test_account_name_not_foo')
    end

    it "should use a :message option for the message" do
      SpecSupport::TestAccountNameValidator.add_validation(:not_foo) { |value| value == 'foo' }
      SpecSupport::TestAccountNameValidator.new(attributes: :field, message: 'bar').validate_each(@model, :field, 'bar')
      @model.errors[:field].should eql([ 'bar' ])
    end
    
    it "should typecast the value to a string" do
      SpecSupport::TestAccountNameValidator.add_validation(:not_foo) { |value| value == 'foo' }
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, :foo)
      @model.errors.should be_empty
    end
  end

  describe ".add_validation" do
    before :each do
      @validator = SpecSupport::TestAccountNameValidator.new(attributes: :field)
    end

    it "should add a validation block" do
      SpecSupport::TestAccountNameValidator.add_validation(:not_foo) { |value| value == 'foo' }
      @validator.validate_each(@model, :field, 'bar')
      @model.errors[:field].should_not be_empty
    end

    it "should do nothing if no block is given" do
      SpecSupport::TestAccountNameValidator.add_validation(:not_foo)
      @validator.validate_each(@model, :field, 'bar')
      @model.errors[:field].should be_empty
    end
  end

  describe ".min_length" do
    it "should ensure a minimum length" do
      SpecSupport::TestAccountNameValidator.min_length 5
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, '1234')
      @model.errors[:field].should_not be_empty
      @model.errors[:field].first.should include('too_short')
    end
  end

  describe ".max_length" do
    it "should ensure a maximum length" do
      SpecSupport::TestAccountNameValidator.max_length 5
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, '123456')
      @model.errors[:field].should_not be_empty
      @model.errors[:field].first.should include('too_long')
    end
  end

  describe ".valid_chars" do
    it "should check for invalid chars" do
      SpecSupport::TestAccountNameValidator.valid_chars '[A-Z]'
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, 'A!Z')
      @model.errors[:field].should_not be_empty
      @model.errors[:field].first.should include('invalid_chars')
    end
  end

  describe ".first_char" do
    it "should check for an invalid first character" do
      SpecSupport::TestAccountNameValidator.first_char '[A-Z]'
      SpecSupport::TestAccountNameValidator.new(attributes: :field).validate_each(@model, :field, 'abc')
      @model.errors[:field].should_not be_empty
      @model.errors[:field].first.should include('invalid_first_char')
    end
  end
end
