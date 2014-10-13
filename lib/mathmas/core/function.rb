module Mathmas
  class Function
    include Basic
    attr_reader :name, :vals

    def initialize(name, vals)
      raise "This is not function" unless vals.all?{|val| val.is_a?(Mathmas::Variable)}
      @expr = nil
      @name = name
      @vals = vals
      Mathmas.add_function self
    end

    def <=(expr)
      raise "The right hand of Mathmas::Function#<- should be an instance of Mathmas::Basic" unless expr.is_a?(Mathmas::Basic)
      @expr = expr
    end

    def to_s
      strs = @vals.map{|val| val.to_s}
      @name.to_s + "(#{ strs.join(",") }) = " + @expr.to_s
    end

    def to_tex
      strs = @vals.map{|val| val.to_s}
      @name.to_s + "(#{ strs.join(",") }) = " + @expr.to_tex
    end

    # @example
    #   f(x) = 1/x
    #   f.exec(x: 3) #-> 1/3
    #   f.exec(3) #-> 1/3
    #
    def exec(*args)
      if args.length == 1 && args[0].is_a?(Hash)
        @expr.exec(args[0])
      else
        symbols = @vals.map{|val| val.symbol}
        hash = args.zip(symbols).reduce({}){|memo, pair| memo[pair[1]] = pair[0]; memo}
        @expr.exec(hash)
      end
    end
  end
end
