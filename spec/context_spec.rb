require 'spec_helper'

describe Rendo::Context do
  subject { Rendo::Context.new }

  it "returns nil for current_regex if one isn't set" do
    subject.current_regex.must_be_nil
  end

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

  it "can override the regex" do
    subject.regexes = [/abc/]
    subject.current_regex = /123/
    subject.current_regex.must_equal /123/
    subject.clear
    subject.current_regex.must_equal /abc/
  end

  it "next implies clear" do
    subject.regexes = [/1/, /2/]
    subject.current_regex = /a/
    subject.next
    subject.current_regex.must_equal /2/
  end

  it "prev implies clear" do
    subject.regexes = [/1/, /2/]
    subject.next
    subject.current_regex = /a/
    subject.prev
    subject.current_regex.must_equal /1/
  end


end
