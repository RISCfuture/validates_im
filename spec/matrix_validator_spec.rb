# frozen_string_literal: true

RSpec.describe MatrixValidator do
  let(:model) { SpecSupport::FakeModel.new }
  let(:validator) { described_class.new(attributes: :field) }

  def run(value)
    validator.validate_each(model, :field, value)
    model.errors[:field]
  end

  it "accepts a valid Matrix ID" do
    expect(run("@alice:matrix.org")).to be_empty
  end

  it "accepts allowed localpart specials" do
    expect(run("@alice.smith_42+work:matrix.example.com")).to be_empty
  end

  it "accepts a server with a port" do
    expect(run("@alice:matrix.example.com:8448")).to be_empty
  end

  it "rejects missing @ prefix" do
    expect(run("alice:matrix.org").first).to include("matrix_invalid_format")
  end

  it "rejects missing colon" do
    expect(run("@alice").first).to include("matrix_invalid_format")
  end

  it "rejects uppercase in localpart" do
    expect(run("@Alice:matrix.org").first).to include("matrix_invalid_format")
  end

  it "rejects an ID over 255 characters" do
    long_local = "a" * 250
    id = "@#{long_local}:matrix.org"
    expect(id.length).to be > 255
    msgs = run(id)
    expect(msgs).to include(a_string_including("matrix_too_long"))
  end

  it "rejects newline injection" do
    expect(run("@alice:matrix.org\nbad")).not_to be_empty
  end
end
