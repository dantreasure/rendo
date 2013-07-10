module Rendo
  class Evaluator

    Commands = %w(match set resume next prev)

    attr_accessor :context

    attr_accessor :pre_match

    attr_accessor :post_match

    def initialize(opts = {})
      @context = opts[:context] || Rendo::Context.new
      self.pre_match = "<<"
      self.post_match = ">>"
    end

    def evaluate(command)
      method_name = command[:command]
      if Commands.include?(method_name)
        self.send(method_name, Array(command[:args]))
      else
        "Unrecognized command: #{method_name}"
      end
    end

    def match(args)
      return "Specify a regular expression first" unless @context.current_regex
      args.first.gsub(context.current_regex, "#{pre_match}\\0#{post_match}")
    end

    def set(args)
      if args.first
        context.current_regex = Regexp.compile(args.first)
        nil
      else
        "Argument required"
      end
    end

    def resume(args)
      context.clear
    end

    def next(args)
      context.next
      "next regex selected"
    end

    def prev(args)
      context.prev
      "previous regex selected"
    end

  end
end