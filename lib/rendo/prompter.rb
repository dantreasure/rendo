module Rendo
  class Prompter

    # Public: The string to prompt with
    attr_accessor :prompt

    def get_input
      Readline.readline(prompt, true)
    end

  end
end
