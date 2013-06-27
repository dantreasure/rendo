require 'spec_helper'

describe Rendo::Prompter do
  subject { Rendo::Prompter.new }

  it "outputs the prefix and the suffix with a space between" do
    subject.prefix = "foo"
    subject.suffix = "> "
    subject.prompt.must_equal("foo > ")
  end

end
