require 'spec_helper'

describe Rendo::Context do
  subject { Rendo::Context.new }

  it "tracks a current position in its regex list" do
    subject.regexes = [/a/, /b/, /c/]
    subject.current_regex.must_equal(/a/)
    subject.next
    subject.current_regex.must_equal(/b/)
    subject.next
    subject.current_regex.must_equal(/c/)
    subject.next
    subject.current_regex.must_be_nil
    subject.prev
    subject.current_regex.must_equal(/c/)
    subject.prev
    subject.current_regex.must_equal(/b/)
  end

  it "matches strings against the current regex" do
    subject.regexes = [/[abc]/, /[def]/]
    subject.match("a").must_be_kind_of(MatchData)
    subject.match("d").must_be_nil
    subject.next
    subject.match("d").must_be_kind_of(MatchData)
  end

end
