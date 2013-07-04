require 'spec_helper'

describe Rendo::Evaluator do

  before do
    @context = stub
  end

  subject { Rendo::Evaluator.new(@context) }

  it "matches strings against the current regex" do
    @context.stubs(current_regex: /[abc]/)
    subject.match(["a"]).must_be_kind_of(MatchData)
    subject.match(["d"]).must_be_nil
  end

  it "has a next command" do
    @context.stubs("next")
    subject.next([])
  end

  it "has a prev command" do
    @context.stubs("prev")
    subject.prev([])
  end

  it "evaluates commands" do
    subject.expects(:match).returns(:foo)
    result = subject.evaluate(command: "match", args: ["abc"])
    result.must_equal :foo
  end

  it "restricts commands to specific methods" do
    result = subject.evaluate(command: "bad_command", args: [])
    result.must_equal "Unrecognized command: bad_command"
  end

end
