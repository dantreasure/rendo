require 'spec_helper'

describe Rendo::Parser do
  before do
    @parser = Rendo::Parser.new
  end

  it "defaults to the test command" do
    @parser.parse("foo").must_equal(
      command: :test,
      arguments: ["foo"],
    )
  end

  it "recognizes bang as a special command" do
    @parser.parse("!foo").must_equal(
      command: :foo,
      arguments: [],
    )
  end

  it "parses shell-style arguments for bang commands" do
    @parser.parse(%Q{!foo one two "three four"}).must_equal(
      command: :foo,
      arguments: ["one", "two", "three four"],
    )
  end

end
