module Mathmas
  # Internal use only
  # Instantiated by Symbol#coerce or Expression#coerce
  #
  # @example
  #   5*(x + y)
  #
  # x + y is calcurated first and an instance of Expression is created.
  # Then Fixnum#* has no rule when its argument is an instance of Expression so Expression#coerce is called.
  # At last Expression#coerce calls Number#new.
  #
  # Multiply(Number(5), Plus(Symbol(x), Symbol(y))
  #
  class Number
    include Mathmas::Basic
    attr_accessor :num

    def initialize(num)
      @num = num
    end

    def to_s
      @num.to_s
    end

    def to_tex
      @num.to_s
    end
  end
end
