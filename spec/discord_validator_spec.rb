# frozen_string_literal: true

RSpec.describe DiscordValidator do
  let(:model) { SpecSupport::FakeModel.new }
  let(:validator) { described_class.new(attributes: :field) }

  def run(value)
    validator.validate_each(model, :field, value)
    model.errors[:field]
  end

  it "accepts a valid modern Discord username" do
    expect(run("alice_42")).to be_empty
  end

  it "accepts an internal period" do
    expect(run("alice.smith")).to be_empty
  end

  it "rejects usernames shorter than 2 characters" do
    expect(run("a").first).to include("discord_too_short")
  end

  it "rejects usernames longer than 32 characters" do
    expect(run("a" * 33).first).to include("discord_too_long")
  end

  it "rejects uppercase letters" do
    expect(run("Alice").first).to include("discord_invalid_chars")
  end

  it "rejects consecutive periods" do
    expect(run("al..ice").first).to include("discord_invalid_format")
  end

  it "rejects leading periods" do
    expect(run(".alice").first).to include("discord_invalid_format")
  end

  it "rejects trailing periods" do
    expect(run("alice.").first).to include("discord_invalid_format")
  end

  it "rejects discriminator-style names" do
    expect(run("alice#1234")).not_to be_empty
  end

  it "rejects a value with embedded newline" do
    expect(run("alice\nbob")).not_to be_empty
  end
end
