module Rendo
  class Repl

    # Public: The Context for the Repl. Commands are executed against the
    # context.
    attr_accessor :context

    # Public: The Prompter for the Repl.
    attr_accessor :prompter

    # Public: The Evaluator for the Repl.
    attr_accessor :evaluator

    # Public: The Parser for the Repl.
    attr_accessor :parser

    # Public: The output stream for printing results.
    attr_accessor :output

    def initialize(options = {})
      self.context   = options[:context]   || Rendo::Context.new
      self.prompter  = options[:prompter]  || Rendo::Prompter.new
      self.parser    = options[:parser]    || Rendo::Parser.new
      self.evaluator = options[:evaluator] || Rendo::Evaluator.new(context: context)
      self.output    = options[:output]    || $stdout
      @prompt = [
        "\n",
        "regex is: ",
        "~regex~",
        "\n",
        "rendo> ",
      ]
      @regex_index = @prompt.find_index("~regex~")
    end

    def rep
      set_prompt
      input = prompter.get_input
      return false unless input

      command = parser.parse(input)
      result = evaluator.evaluate(command)
      output.puts(result) if result
      true
    end

    def repl
      while rep
      end
    end

    private

    def set_prompt
      @prompt[@regex_index] = if context.current_regex
        context.current_regex.source
      else
        "no regex set"
      end
      prompter.prompt = @prompt.join
    end
  end
end
