require 'spec_helper'

describe Rendo::Repl do
  before do
    @command = { command: "blah", arguments: []}
    #@prompter = stub(:prefix= => nil, :suffix= => nil, :prefix => n)
    @prompter = stub(:prompt => "prompt", :prompt= => nil)
    @parser = stub(parse: @command)
    @evaluator = mock
    @output = StringIO.new
    @io = mock
  end

  subject do
    Rendo::Repl.new(
      prompter:  @prompter,
      parser:    @parser,
      evaluator: @evaluator,
      output:    @output,
    )
  end

  describe ".rep" do
    it "performs a rep" do
      subject.context.current_regex = /foo/
      @prompter.expects(:prompt=).with("\nregex is: foo\nrendo> ")
      @prompter.expects(:get_input).returns("input")
      @evaluator.expects(:evaluate).with(@command).returns("result")
      result = subject.rep
      result.must_equal true
      @output.string.must_equal("result\n")
    end

    it "returns false on eof" do
      @prompter.expects(:get_input)
      result = subject.rep
      result.must_equal false
    end

    it "outputs nothing when evaulate returns nil" do
      @prompter.expects(:get_input).returns("input")
      @evaluator.expects(:evaluate).returns(nil)
      subject.rep
      @output.string.must_be :empty?
    end

  end

  describe ".repl" do
    it "repeatedly performs rep" do
      @prompter.expects(:get_input).twice.returns("input", nil)
      @evaluator.stubs(:evaluate)
      subject.repl
    end
  end
end
