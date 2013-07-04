require 'shellwords'

module Rendo
  class Parser
    def parse(text)
      case text
      when /^!/
        tokens = Shellwords.split(text)
        {
          command: tokens.first.gsub(/^!/, ''),
          arguments: tokens[1..-1],
        }
      else
        {
          command: "match",
          arguments: [text],
        }
      end
    end
  end
end