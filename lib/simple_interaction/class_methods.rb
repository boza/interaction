module SimpleInteraction
  module ClassMethods

    attr_accessor :requirements

    # required arguments to run interaction `requires :param`
    def requires(*attrs)
      set_requirements(attrs)
    end

    # interaction requirements
    def requirements
      @requirements ||= []
    end

    # specifies the error class that will be raise if interaction is run with !
    # if nothing is set InteractionError will be the default error class
    def fail_with(klass)
      @error_class = self.const_set(klass, Class.new(InteractionError))
    end

    def error_class
      @error_class ||= InteractionError
    end

    # checks if requirements are met from the requires params
    # creates an instance of the interaction 
    # calls run on the instance
    def run(**options)
      @options = options
      fail RequirementsNotMet.new("#{self} requires the following parameters #{requirements}") unless requirements_met?
      new(@options).tap do |interaction|
        interaction.__send__(:run)
      end
    end

    # runs interaction raises if any error or returns the interaction result
    def run!(**options)
      interaction = run(options)
      raise error_class.new(interaction.error) unless interaction.success?
      interaction.result
    end

    private

    def requirements_met?
      return true if requirements.empty?
      return false unless @options.kind_of?(Hash)
      requirements.each do |accessor|
        break false unless @options.has_key?(accessor)
      end
    end

    def set_requirements(attrs)
      attr_reader *attrs
      requirements.unshift(*attrs)
    end
  end
end
