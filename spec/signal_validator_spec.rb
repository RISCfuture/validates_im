# frozen_string_literal: true

RSpec.describe SignalValidator do
  let(:model) { SpecSupport::FakeModel.new }
  let(:validator) { described_class.new(attributes: :field) }

  def run(value)
    validator.validate_each(model, :field, value)
    model.errors[:field]
  end

  it "accepts a valid username" do
    expect(run("alice.42")).to be_empty
  end

  it "accepts a discriminator with leading zeros" do
    expect(run("alice.0123")).to be_empty
  end

  it "rejects usernames shorter than 3 chars" do
    expect(run("ab").first).to include("signal_too_short")
  end

  it "rejects usernames longer than 32 chars" do
    expect(run("#{'a' * 28}.4242")).not_to be_empty
  end

  it "rejects names without a discriminator" do
    expect(run("alice").first).to include("signal_invalid_format")
  end

  it "rejects a single-digit discriminator" do
    expect(run("alice.4").first).to include("signal_invalid_format")
  end

  it "rejects names starting with a digit" do
    expect(run("1alice.42").first).to include("signal_invalid_format")
  end

  it "rejects non-numeric discriminators" do
    expect(run("alice.bob").first).to include("signal_invalid_format")
  end
end
