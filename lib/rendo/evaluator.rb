module Rendo
  class Evaluator

    Effects = {
      off:      "",
      normal:   "\033[0m",
      bold:     "\033[1m",
      reverse:  "\033[7m",
      blink:    "\033[5m",
    }

    Colors = {
      off:     "",
      black:   "\033[30m",
      red:     "\033[31m",
      green:   "\033[32m",
      brown:   "\033[33m",
      blue:    "\033[34m",
      magenta: "\033[35m",
      cyan:    "\033[36m",
      gray:    "\033[37m",
    }

    Backgrounds = {
      off:     "",
      black:   "\033[40m",
      red:     "\033[41m",
      green:   "\033[42m",
      brown:   "\033[43m",
      blue:    "\033[44m",
      magenta: "\033[45m",
      cyan:    "\033[46m",
      gray:    "\033[47m",
    }

    QuotePairs = {
      normal:         ["<<", ">>"],
      reverse:        [">>", "<<"],
      angle:          ["«", "»"],
      reverse_angle:  ["»", "«"],
      off:            ["", ""]
    }

    Commands = %w(quit load match set resume next prev size goto quote color background effect reset)

    MatchFormat = "%{color}%{background}%{effect}%{prefix}\\0%{suffix}%{normal}"

    attr_accessor :context

    attr_accessor :match_color
    attr_accessor :match_background
    attr_accessor :match_effect
    attr_accessor :match_prefix
    attr_accessor :match_suffix

    def initialize(opts = {})
      @context = opts[:context] || Rendo::Context.new
      quote(['normal'])
      color(['off'])
      background(['off'])
      effect(['off'])
    end

    def evaluate(command)
      method_name = command[:command]
      if Commands.include?(method_name)
        self.send(method_name, Array(command[:args]))
      else
        "Unrecognized command: #{method_name}"
      end
    end

    def quit(args)
      context.should_quit = true
      nil
    end

    def load(args)
      arg = args.first
      return "Argument required" unless arg
      return "File not found: #{arg}" unless File.exists?(arg)
      regex_strs = File.readlines(arg).map(&:strip)
      context.regexes = regex_strs.map { |s| Regexp.compile(s) }
      "#{context.regexes.size} regexes loaded"
    end

    def match(args)
      return "Specify a regular expression first" unless @context.current_regex

      final = if [match_color, match_background, match_effect].all?(&:empty?)
        ""
      else
        Effects[:normal]
      end

      replacement = MatchFormat % {
        color:      match_color,
        background: match_background,
        effect:     match_effect,
        prefix:     match_prefix,
        suffix:     match_suffix,
        normal:     final,
      }
      args.first.gsub(context.current_regex, replacement)
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

    def size(args)
      context.regexes.size.to_s
    end

    def goto(args)
      return "Argument required" unless args.first
      context.current_index = args.first.to_i
    end

    def quote(args)
      key = args.first.to_sym
      quotes = QuotePairs[key]
      return "Unrecognized quote type: #{key}" unless quotes
      @match_prefix, @match_suffix = quotes
      nil
    end

    def reset(args)
      color(['off'])
      background(['off'])
      effect(['off'])
    end

    def color(args)
      key = args.first.to_sym
      color = Colors[key]
      return "Unrecognized color: #{key}" unless color
      self.match_color = color
      nil
    end

    def background(args)
      key = args.first.to_sym
      background = Backgrounds[key]
      return "Unrecognized background: #{key}" unless background
      self.match_background = background
      nil
    end

    def effect(args)
      key = args.first.to_sym
      effect = Effects[key]
      return "Unrecognized effect: #{key}" unless effect
      self.match_effect = effect
      nil
    end

  end
end