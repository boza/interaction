module SimpleInteraction
  #main interaction error class
  class InteractionError< StandardError;end

  # this exception is raised when any arguments on `requires` method is missing
  class RequirementsNotMet < InteractionError;end

  # this exception will be raised if no run method is implemented on the interaction class
  class NotImplemented < InteractionError;end
end
