module Mathmas
  # Class for Symbol like x, y, etc.
  class Variable
    include Mathmas::Basic
    attr_reader :symbol

    def initialize(symbol)
      @symbol = symbol
    end

    def to_s
      @symbol.to_s
    end

    def to_tex
      @symbol.to_s
    end
  end
end
