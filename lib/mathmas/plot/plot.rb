require 'nyaplot'
require_relative 'function'

module Mathmas
  def plot(obj, *args)
    if obj.is_a?(Function)
      Mathmas.plot_function(obj, args[0])
    end
  end

  module_function :plot
end
