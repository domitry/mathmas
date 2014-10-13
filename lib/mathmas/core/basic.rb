module Mathmas
  module Basic
    # TODO: delete the line arg=( ? : )
    def +(arg)
      arg = (arg.is_a?(Numeric) ? Number.new(arg) : arg)
      Plus.new(self, arg)
    end

    def -(arg)
      arg = (arg.is_a?(Numeric) ? Number.new(arg) : arg)
      Plus.new(self, Multiply.new(Number.new(-1), arg))
    end

    def *(arg)
      arg = (arg.is_a?(Numeric) ? Number.new(arg) : arg)
      Multiply.new(self, arg)
    end

    def /(arg)
      arg = (arg.is_a?(Numeric) ? Number.new(arg) : arg)
      if self.is_a?(Number) && self.num == 1
        Power.new(arg, Number.new(-1))
      else
        Multiply.new(self, Power.new(arg, Number.new(-1)))
      end
    end

    def **(arg)
      arg = (arg.is_a?(Numeric) ? Number.new(arg) : arg)
      Power.new(self, arg)
    end

    def coerce(other)
      if other.is_a? Numeric
        return Mathmas::Number.new(other), self
      else
        raise "There is no rule for handling #{other.to_s}."
      end
    end

    def to_iruby
      # Dirty Hack for IRuby. I hope IRuby will fix the problem in the future.
      # ["text/latex", self.to_tex] not work.
      html = "<script type=\"math/tex; mode=display\">#{ self.to_tex }</script>"
      ['text/html', html]
    end
  end
end
