require 'spec_helper'

describe Rendo::Repl do
  before do
    @command = { command: "blah", arguments: []}
    @context = mock
    @prompter = stub(prompt: "prompt>")
    @parser = stub(parse: @command)
    @evaluator = mock
    @printer = mock
    @io = mock
  end

  subject do
    Rendo::Repl.new(
      context:   @context,
      prompter:  @prompter,
      parser:    @parser,
      evaluator: @evaluator,
      printer:   @printer,
    )
  end

  describe ".rep" do
    it "performs a rep" do
      Readline.expects(:readline).with("prompt>", true).returns("input")
      @evaluator.expects(:evaluate).with(@command).returns(:result)
      @printer.expects(:print).with(:result)
      result = subject.rep
      result.must_equal true
    end

    it "returns false on eof" do
      Readline.expects(:readline).returns(nil)
      result = subject.rep
      result.must_equal false
    end
  end

  describe ".repl" do
    it "repeatedly performs rep" do
      Readline.expects(:readline).twice.returns("input", nil)
      @evaluator.stubs(:evaluate)
      @printer.stubs(:print)
      subject.repl
    end
  end
end
