module Rendo
  class Prompter

    # Public: The first part of the prompt that can be set independently.
    attr_accessor :prefix

    # Public: The last part of the prompt that can be set independently.
    attr_accessor :suffix

    def prompt
      "#{prefix} #{suffix}"
    end

  end
end
