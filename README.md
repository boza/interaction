# Interaction

Interactions are meant to keep controllers and models or any other business logic slim (YAY).
Keep intention of class clear when using interactions, for example: 
To create a user, a class should be name Users::Create.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'interaction'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install interaction

## Usage

```
class Klass
  include Interaction

  fail_with 'ErrorClass'
  requires :param1, :param2     

  private
  
  def run
    method
  rescue => e
    @error = e.message
  end

  def method
    param1 / param2
  end

end

interaction = Klass.run(param1: 2, param2: 1)
interaction.success? #=> true
interaction.error #=> nil
interaction.result #=> 2

Klass.run!(param1: 1, param2: 0) #=> raises Klass::ErrorClass
Klass.run!(param1: 1, param2: 2) #=> 2

```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/interaction/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
