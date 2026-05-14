# frozen_string_literal: true

RSpec.describe SteamValidator do
  let(:model) { SpecSupport::FakeModel.new }
  let(:validator) { described_class.new(attributes: :field) }

  def run(value)
    validator.validate_each(model, :field, value)
    model.errors[:field]
  end

  it "accepts a valid Steam ID with underscores and digits" do
    expect(run("alice_42")).to be_empty
  end

  it "rejects too-short IDs" do
    expect(run("ab").first).to include("steam_too_short")
  end

  it "rejects invalid characters" do
    expect(run("alice!").first).to include("steam_invalid_chars")
  end
end
