# Mathmas

Mathmas is a gem for Symbolic Mathematics inspired by [SymPy](https://github.com/sympy/sympy) and [dydx](https://github.com/gogotanaka/dydx). This gem is still an experimental implementation and needs your help. Please contact me if you are interest in contributing it.

The word "Mathmas" comes from "ますます"(Mas-Mas) which means "more and more" in Japanese.

## Installation

Add this line to your application's Gemfile:

    gem 'mathmas'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mathmas

## Usage

```ruby
require 'mathmas'
include Mathmas
f(x) = x**2
f.plot(x: -1..1) #-> Plot on IRuby notebook
f.diff #-> 2*x
f.integrate(x: -1..1)
f.minimize
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/mathmas/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
