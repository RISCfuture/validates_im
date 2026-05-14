# frozen_string_literal: true

RSpec.describe XboxLiveValidator do
  let(:model) { SpecSupport::FakeModel.new }
  let(:validator) { described_class.new(attributes: :field) }

  def run(value)
    validator.validate_each(model, :field, value)
    model.errors[:field]
  end

  it "accepts a valid gamertag" do
    expect(run("Major Nelson")).to be_empty
  end

  it "rejects gamertags longer than 12 characters" do
    expect(run("a" * 13).first).to include("xbox_too_long")
  end

  it "rejects an empty string with a sane too-short error (regression: used to NPE on value[0])" do
    expect { run("") }.not_to raise_error
    expect(model.errors[:field].first).to include("xbox_too_short")
  end

  it "rejects gamertags starting with a digit" do
    expect(run("1Cool")).not_to be_empty
  end

  it "rejects gamertags with invalid characters" do
    expect(run("Major!").first).to include("xbox_invalid_chars")
  end
end
