module Rendo
  class Context
    def initialize
      @regexes = []
      @current_index = 0
    end

    # Public: The list of regexes to test with
    attr_accessor :regexes

    # Public: A flag to determine if the repl should quit
    attr_accessor :should_quit

    # Public: Get the current regex
    def current_regex
      @current_regex || regexes[@current_index]
    end

    def current_regex=(new_regex)
      @current_regex = new_regex
    end

    def current_index
      @current_index
    end

    def current_index=(new_index)
      @current_index = new_index
      normalize_index
    end

    def regex_overridden?
      !!@current_regex
    end

    def next
      clear
      @current_index += 1
      normalize_index
    end

    def prev
      clear
      @current_index -= 1
      normalize_index
    end

    def clear
      @current_regex = nil
    end

    private

    def normalize_index
      @current_index = [[0, @current_index].max, regexes.size].min
    end

  end
end