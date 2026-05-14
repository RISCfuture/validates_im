# frozen_string_literal: true

RSpec.describe AimValidator do
  let(:model) { SpecSupport::FakeModel.new }
  let(:validator) { described_class.new(attributes: :field) }

  def run(value)
    validator.validate_each(model, :field, value)
    model.errors[:field]
  end

  it "accepts a valid screen name" do
    expect(run("abc123")).to be_empty
  end

  it "rejects screen names that are too short" do
    expect(run("ab").first).to include("aim_too_short")
  end

  it "rejects screen names that are too long" do
    expect(run("a" * 17).first).to include("aim_too_long")
  end

  it "rejects screen names with invalid characters" do
    expect(run("abc!").first).to include("aim_invalid_chars")
  end

  it "rejects screen names that don't start with a letter" do
    expect(run("1abc").first).to include("aim_invalid_first_char")
  end

  it "rejects a value with an embedded newline (regression for multiline bypass)" do
    msgs = run("valid\nBAD!")
    expect(msgs).not_to be_empty
  end
end
