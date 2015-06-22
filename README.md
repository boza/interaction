[![Code Climate](https://codeclimate.com/github/boza/interaction/badges/gpa.svg)](https://codeclimate.com/github/boza/interaction)

[ ![Codeship Status for boza/interaction](https://codeship.com/projects/bfb931b0-fb51-0132-06e2-1658e61aa1b1/status?branch=master)](https://codeship.com/projects/87156)

# Interaction

Interactions are meant to keep controllers and models or any other business logic slim (YAY).
Keep intention of class clear when using interactions, for example: 
To create a user, a class should be name Users::Create.

If you are using this in a Rails application you might want to use

```ruby
gem 'simple_interaction-rails, github: "boza/simple_interaction-rails"'
```

this comes with a generator so you don't have to create individual files :)



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_interaction'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_interaction

## Usage

```
class Klass
  include SimpleInteraction

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
