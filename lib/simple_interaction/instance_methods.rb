module SimpleInteraction
  module InstanceMethods

    # error message if interaction was not successful
    attr_accessor :error

    # result of interaction, set when interaction was successful in otherwise is nil
    attr_accessor :result

    def success?
      error.nil?
    end

    private

    # sets the attr_accessor for each requirement of the intereaction
    def initialize(**opts)
      opts.select { |option, _| self.class.requirements.include?(option) }.each do |accessor, value|
        __send__("#{accessor}=", value)
        opts.delete(accessor)
      end
      set_optional_data(opts)
    end

    def set_optional_data(opts)
      @optional_params = {}
      opts.each do |key, value|
        @optional_params[key] = value
      end
    end

    # run method should be overwritten on every class where interaction is included
    def run
      fail NotImplemented.new("`run` instance method must be implemented in class #{self.class}") unless defined?(super)
      interaction_run = super
      if success?
        @result = interaction_run
      end
    end
  end
end
