module Rendo
  class Evaluator

    Commands = %w(match next prev)

    def initialize(context)
      @context = context
    end

    def evaluate(command)
      method_name = command[:command]
      if Commands.include?(method_name)
        self.send(method_name, command[:args])
      else
        "Unrecognized command: #{method_name}"
      end
    end

    def match(args)
      @context.current_regex.match(args.first)
    end

    def next(args)
      @context.next
    end

    def prev(args)
      @context.prev
    end

  end
end