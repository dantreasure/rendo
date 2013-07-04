module Rendo
  class Context
    def initialize
      @current_index = 0
    end

    # Public: The list of regexes to test with
    attr_accessor :regexes

    # Public: Get the regex at the current position
    def current_regex
      regexes[@current_index]
    end

    def next
      @current_index = [@current_index + 1, regexes.size].min
    end

    def prev
      @current_index = [@current_index - 1, 0].max
    end


  end
end