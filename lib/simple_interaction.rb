require "simple_interaction/version"
require "simple_interaction/exceptions"
require "simple_interaction/instance_methods"
require "simple_interaction/class_methods"

module SimpleInteraction

  # = Simple Interaction
  #
  # Interactions are meant to keep controllers and models slim (YAY).
  # Keep intention of class clear when using interactions
  # for example to create a user a class should be name Users::Create.
  #
  #
  # example of usage:
  #
  #   class Klass
  #     include Interaction
  #
  #     requires :param1, :param2
  #
  #     private
  #
  #     def run
  #       method
  #     end
  #
  #     def method
  #       param1 * param2
  #     end
  #
  #   end
  #
  #  Klass.run(param1: param1, param2: param2)

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :prepend, InstanceMethods
  end
end
