module Mathmas
  def method_missing(name, *args)
    if /[a-zA-Z]/ =~ name && name.to_s.length == 1
      if args.length == 0
        if Mathmas.find_function(name).nil?
          return Mathmas::Variable.new(name)
        else
          return Mathmas.find_function(name)
        end
      else
        if args.all? {|arg| arg.is_a?(Numeric)}
          func = Mathmas.find_function(name)
          return func.exec(*args)
        else
          return Mathmas::Function.new(name, args)
        end
      end
    end
    super
  end

  def add_function(func)
    raise "The first argument should be an instance of Mathmas#Function" unless func.is_a?(Function)
    @@functions[func.name] = func
  end

  def find_function(name)
    @@functions[name]
  end

  @@functions = {}
  module_function :add_function, :find_function
end
