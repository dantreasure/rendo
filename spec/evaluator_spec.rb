require 'spec_helper'

describe Rendo::Evaluator do

  subject { Rendo::Evaluator.new }

  before do
    @context = subject.context
  end

  it "matches strings against the current regex" do
    @context.current_regex= /[abc]/
    result = subject.evaluate(command: 'match', args: ["1a2"])
    result.must_equal("1<<a>>2")
    subject.match(["d"]).must_equal "d"
  end

  it "evaluates commands" do
    subject.expects(:match).with(["abc"]).returns("foo")
    result = subject.evaluate(command: "match", args: ["abc"])
    result.must_equal "foo"
  end

  it "only evaluates recognized commands" do
    result = subject.evaluate(command: "unknown")
    result.must_equal "Unrecognized command: unknown"
  end

  it "has a quit command" do
    result = subject.evaluate(command: "quit")
    result.must_be_nil
    @context.should_quit.must_equal true
  end

  it "has a set command" do
    result = subject.evaluate(command: 'set', args: ["abc"])
    result.must_be_nil
    @context.current_regex.must_equal(/abc/)
  end

  it "has a resume command" do
    @context.regexes = [/abc/, /123/]
    @context.next
    @context.current_regex = /def/
    result = subject.evaluate(command: 'resume')
    result.must_be_nil
    @context.current_regex.must_equal(/123/)
  end

  it "has a next command" do
    @context.regexes = [/abc/, /def/]
    result = subject.evaluate(command: 'next')
    result.must_equal("next regex selected")
    @context.current_regex.must_equal /def/
  end

  it "has a prev command" do
    @context.stubs("prev")
    subject.prev([])
  end
end
