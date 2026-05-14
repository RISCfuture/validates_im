# frozen_string_literal: true

RSpec.describe YahooImValidator do
  let(:model) { SpecSupport::FakeModel.new }
  let(:validator) { described_class.new(attributes: :field) }

  def run(value)
    validator.validate_each(model, :field, value)
    model.errors[:field]
  end

  it "accepts a valid screen name" do
    expect(run("alice")).to be_empty
  end

  it "accepts a single period" do
    expect(run("alice.j")).to be_empty
  end

  it "rejects too-short names" do
    expect(run("abc").first).to include("yim_too_short")
  end

  it "rejects two periods" do
    expect(run("a.b.c").first).to include("yim_multiple_periods")
  end

  it "rejects invalid characters" do
    expect(run("alice!").first).to include("yim_invalid_chars")
  end
end
