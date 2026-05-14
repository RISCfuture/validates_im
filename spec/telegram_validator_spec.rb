# frozen_string_literal: true

RSpec.describe TelegramValidator do
  let(:model) { SpecSupport::FakeModel.new }
  let(:validator) { described_class.new(attributes: :field) }

  def run(value)
    validator.validate_each(model, :field, value)
    model.errors[:field]
  end

  it "accepts a valid username" do
    expect(run("alice_42")).to be_empty
  end

  it "strips an optional leading @" do
    expect(run("@alice_42")).to be_empty
  end

  it "rejects usernames shorter than 5 characters" do
    expect(run("a_4").first).to include("telegram_too_short")
  end

  it "rejects usernames longer than 32 characters" do
    expect(run("a" * 33).first).to include("telegram_too_long")
  end

  it "rejects names not starting with a letter" do
    expect(run("1alice")).not_to be_empty
  end

  it "rejects names ending with an underscore" do
    expect(run("alice_").first).to include("telegram_trailing_underscore")
  end

  it "rejects invalid characters" do
    expect(run("alice.bob").first).to include("telegram_invalid_chars")
  end
end
