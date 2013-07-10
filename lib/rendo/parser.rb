require 'shellwords'

module Rendo
  class Parser
    def parse(text)
      case text
      when /^!/
        tokens = Shellwords.split(text)
        {
          command: tokens.first.gsub(/^!/, ''),
          args: tokens[1..-1],
        }
      else
        {
          command: "match",
          args: [text],
        }
      end
    end
  end
end