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

    # Public: The Printer for the Repl.
    attr_accessor :printer

    def initialize(options = {})
      self.context   = options[:context]   || Rendo::Context.new
      self.prompter  = options[:prompter]  || Rendo::Prompter.new
      self.parser    = options[:parser]    || Rendo::Parser.new
      self.evaluator = options[:evaluator] || Rendo::Evaluator.new(context)
      self.printer   = options[:printer]   || Rendo::Printer.new
    end

    def rep
      input = Readline.readline(prompter.prompt, true)
      return false unless input

      command = parser.parse(input)
      result = evaluator.evaluate(command)
      printer.print(result)
      true
    end

    def repl
      while rep
      end
    end

  end
end
