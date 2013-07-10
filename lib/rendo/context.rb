module Rendo
  class Context
    def initialize
      @regexes = []
      @current_index = 0
    end

    # Public: The list of regexes to test with
    attr_accessor :regexes

    # Public: Get the current regex
    def current_regex
      @current_regex || regexes[@current_index]
    end

    def current_regex=(new_regex)
      @current_regex = new_regex
    end

    def next
      clear
      @current_index = [@current_index + 1, regexes.size].min
    end

    def prev
      clear
      @current_index = [@current_index - 1, 0].max
    end

    def clear
      @current_regex = nil
    end

  end
end