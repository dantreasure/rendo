require 'spec_helper'

describe Rendo::Prompter do
  subject { Rendo::Prompter.new }

  it "calls readline with prompt and returns result" do
    Readline.expects(:readline).with("foo> ", true).returns("result string")
    subject.prompt = "foo> "
    subject.get_input.must_equal "result string"
  end

end
