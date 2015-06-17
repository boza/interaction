require "simple_interaction/version"

module SimpleInteraction

  # = Interactions
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

  class InteractionError< StandardError;end
  class RequirementsNotMet < InteractionError;end
  class NotImplemented < InteractionError;end

  module ClassMethods

    attr_accessor :accessors

    def accessors
      @accessors ||= []
    end

    def error_class
      @error_class ||= InteractionError
    end
    
    # class method to make sure parameters are required for the interaction to work.
    def requires(*attrs)
      set_accessors(attrs)
    end

    def fail_with(klass)
      @error_class = self.const_set(klass, Class.new(InteractionError))
    end

    # checks if requirements are met from the requires params
    # creates an instance of the interaction 
    # calls run on the instance
    def run(**options)
      @options = options
      fail RequirementsNotMet.new("#{self} requires the following parameters #{accessors}") unless requirements_met?
      new(@options).__send__(:run)
    end

    def run!(**options)
      interaction = run(options)
      raise error_class.new(interaction.error) unless interaction.success?
      interaction.result
    end

    private

    def requirements_met?
      return true if accessors.empty?
      return false unless @options.kind_of?(Hash)
      accessors.each do |accessor|
        break false unless @options.has_key?(accessor)
      end
    end

    def set_accessors(attrs)
      attr_accessor *attrs
      accessors.unshift(*attrs)
    end

  end
  
  module InstanceMethods

    attr_accessor :error, :result, :error_class

    def success?
      error.nil?
    end

    private

    # initializes instance and sets the instance variable for each attr_accessor from the required parameters
    def initialize(**opts)

      opts.select { |option, _| self.class.accessors.include?(option) }.each do |accessor, value|
        __send__("#{accessor}=", value)
      end
    end

    # run method should be overwritten on every class where interaction is included
    def run
      fail NotImplemented.new("`run` instance method must be implemented in class #{self.class}") unless defined?(super)
      interaction_run = super
      @result = interaction_run if success?
      self
    end    

  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :prepend, InstanceMethods
  end
end