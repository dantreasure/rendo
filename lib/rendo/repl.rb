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
      @prompt_template = "\nregex %{index}: %{regex}\nrendo> "
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
      while !context.should_quit && rep
      end
    end

    private

    def set_prompt
      regex_str = if context.current_regex
        context.current_regex.source
      else
        ""
      end

      index_str ||= if regex_str.empty?
        "not set"
      elsif context.regex_overridden?
        "(custom)"
      else
        "##{context.current_index}"
      end

      prompter.prompt = @prompt_template % {
        index: index_str,
        regex: regex_str,
      }
    end
  end
end
