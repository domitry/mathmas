module Mathmas
  # Mathmas#plot_function plot Mathmas::Function.
  # @example
  #   f(x) = 1/x
  #   f.plot(func, x: 1..2)
  #
  #   g(x, y, a, b) = a*x**2 + b*y**2
  #   g.plot(a: 3, b: 3, x: -1..1, y: -1..1)
  #
  def plot_function(func, args={})
    args={div_num: 100}.merge(args)

    div_num = args[:div_num]
    args.delete :div_num

    ranges = args.select{|key, val| val.is_a?(Range)}
    numerics = args.select{|key, val| val.is_a?(Numeric)}

    raise "the number of arguments is wrong" unless ranges.length + numerics.length == func.vals.length

    case ranges.length
    when 2
      plot = Nyaplot::Plot3D.new
      return plot
    when 1
      plot = Nyaplot::Plot.new
      x_label = ranges.keys[0]
      range = ranges[x_label]
      step = (range.last.to_f - range.begin.to_f)/(div_num-1)

      x_arr = []; div_num.times {|i| x_arr.push(range.begin + step*i)}
      y_arr = x_arr.map{|x| func.exec({x_label => x})}

      plot.add(:line, x_arr, y_arr)
      plot.x_label(x_label)
      plot.y_label(func.to_s)

      return plot
    else
      raise "Nyaplot cannot plot function whose dimention > 3"
    end
  end

  module_function :plot_function

  class Function
    def plot(args)
      Mathmas.plot_function(self, args)
    end
  end
end
