require 'spec_helper'

describe Rendo::Repl do
  before do
    @command = { command: "blah", arguments: []}
    #@prompter = stub(:prefix= => nil, :suffix= => nil, :prefix => n)
    @prompter = stub(:prompt => "prompt")
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
      subject.context.regexes = [/foo/]
      @prompter.expects(:prompt=).with("\nregex #0: foo\nrendo> ")
      @prompter.expects(:get_input).returns("input")
      @evaluator.expects(:evaluate).with(@command).returns("result")
      result = subject.rep
      result.must_equal true
      @output.string.must_equal("result\n")
    end

    it "indicates when custom when custom regex is set" do
      subject.context.current_regex = /foo/
      @prompter.expects(:prompt=).with("\nregex (custom): foo\nrendo> ")
      @prompter.expects(:get_input).returns("input")
      @evaluator.expects(:evaluate).with(@command).returns("result")
      result = subject.rep
      result.must_equal true
      @output.string.must_equal("result\n")
    end

    it "indicates when there is no current regex" do
      @prompter.expects(:prompt=).with("\nregex not set: \nrendo> ")
      @prompter.expects(:get_input).returns("input")
      @evaluator.expects(:evaluate).with(@command).returns("result")
      result = subject.rep
      result.must_equal true
      @output.string.must_equal("result\n")
    end

    it "returns false on eof" do
      @prompter.stubs(:prompt=)
      @prompter.expects(:get_input)
      result = subject.rep
      result.must_equal false
    end

    it "outputs nothing when evaulate returns nil" do
      @prompter.stubs(:prompt=)
      @prompter.expects(:get_input).returns("input")
      @evaluator.expects(:evaluate).returns(nil)
      subject.rep
      @output.string.must_be :empty?
    end

  end

  describe ".repl" do
    it "repeatedly performs rep" do
      @prompter.stubs(:prompt=)
      @prompter.expects(:get_input).twice.returns("input", nil)
      @evaluator.stubs(:evaluate)
      subject.repl
    end

    it "exits if context#should_quit is true" do
      subject.context.should_quit = true
      @prompter.stubs(:prompt=)
      @prompter.expects(:get_input).never
      subject.repl
    end
  end
end
