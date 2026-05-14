# frozen_string_literal: true

RSpec.describe SkypeValidator do
  let(:model) { SpecSupport::FakeModel.new }
  let(:validator) { described_class.new(attributes: :field) }

  def run(value)
    validator.validate_each(model, :field, value)
    model.errors[:field]
  end

  it "accepts a valid Skype name" do
    expect(run("alice123")).to be_empty
  end

  it "rejects short names" do
    expect(run("abc").first).to include("skype_too_short")
  end

  it "rejects names that don't start with a letter" do
    expect(run("1alice2")).not_to be_empty
  end
end
