module Mathmas
  # Currently Mathmas have 3 types of expression, Plus, Multiply and Power.
  # All calcs including dividing are expressed with these three.
  #
  # @example
  #   1/(x + y)
  #
  # Multiply(Number(1), Power(Plus(Symbol(x), Symbol(y), -1))
  #
  class Expression
    include Mathmas::Basic

    def initialize(*args)
      @args = args
    end

    # @example
    #   (1/x).exec(x: 3) #-> 1/3
    #   (1/(x*y)).exec(x: 3) #-> 1/(3*x)
    def exec(args)
      arr = @args.map do |arg|
        if arg.is_a?(Variable)
          unless args.keys.index(arg.symbol).nil?
            next args[arg.symbol]
          else
            next arg
          end
        elsif arg.is_a?(Expression)
          next arg.exec(args)
        elsif arg.is_a?(Number)
          next arg.num
        else
          raise "Invailed Arguments"
        end
      end
      arr
    end
  end

  class Plus < Expression
    def to_s
      @args.map{|arg| arg.to_s}.join(" + ")
    end

    def to_tex
      @args.map{|arg| arg.to_tex}.join(" + ")
    end

    def exec(args)
      super(args).inject(:+)
    end
  end

  class Multiply < Expression
    def to_s
      arr = @args.map do |arg|
        str = arg.to_s
        (arg.is_a?(Mathmas::Expression) ? "(" + str + ")" : str)
      end
      arr.join("*")
    end

    # TODO: (-1)*x -> -x, (-3)*x -> -3x
    def to_tex
      arr = @args.map do |arg|
        str = arg.to_tex
        (arg.is_a?(Mathmas::Expression) ? "(" + str + ")" : str)
      end
      arr.join("*")
    end

    def exec(args)
      super(args).inject(:*)
    end
  end

  # @args = [3, 2] -> 3^2
  class Power < Expression
    def to_s
      arr = @args.map do |arg|
        str = arg.to_s
        (arg.is_a?(Mathmas::Expression) ? "(" + str + ")" : str)
      end
      arr.join("^")
    end

    # TODO: display root when args[1].is_a? Rational
    def to_tex(numerator = Number.new(1))
      strs = @args.map do |arg|
        str = arg.to_tex
        (arg.is_a?(Mathmas::Expression) ? "(" + str + ")" : str)
      end

      if @args[1].is_a?(Number) && @args[1].num < 0
        denominator = (@args[1].num == -1 ? strs[0] : strs[0] + "^" + (-@args[1].num).to_s)
        "\\frac{#{ numerator.to_tex }}{#{ denominator }}"
      else
        strs.join("^")
      end
    end

    def exec(args)
      super(args).inject(:**)
    end
  end
end
