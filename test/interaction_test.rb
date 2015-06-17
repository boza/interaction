require 'minitest/autorun'
require 'simple_interaction'

class Interactor
  include SimpleInteraction

  fail_with 'InteractorExp'

  requires :param

  def run
    @error = "only strings please" if param =~ /\d{1,}/
    "This is the result for #{param}"
  end

end

class InteractorNotImplemented
  include SimpleInteraction
end

module SimpleInteraction
  class InteractionTest < ::Minitest::Test

    def test_private_run
      assert Interactor.private_method_defined?(:run), 'instance method run should be private'
    end

    def test_error_class
      assert_equal Interactor::InteractorExp, Interactor.error_class
    end

    def test_error_class_not_defined
      assert_equal SimpleInteraction::InteractionError, InteractorNotImplemented.error_class
    end

    def test_should_require_params
      assert_raises RequirementsNotMet do
        Interactor.run
      end
    end

    def test_result
      assert_equal "This is the result for awesome interaction", Interactor.run(param: 'awesome interaction').result
    end

    def test_success
      assert Interactor.run(param: 'awesome interaction').success?, 'Interactor didn\'t finish successfuly' 
    end

    def test_run_with_bang
      assert_equal "This is the result for awesome interaction", Interactor.run!(param: 'awesome interaction')
    end

    def test_error
      interaction = Interactor.run(param: '1')
      refute interaction.success?, 'Interactor didn\'t finish with an error' 
      assert_match interaction.error, "only strings please"
    end

    def test_error_with_bang
      exception = assert_raises(Interactor::InteractorExp) { Interactor.run!(param: '1') }
      assert_equal "only strings please", exception.message
    end

    def test_not_implemented
       assert_raises(SimpleInteraction::NotImplemented) { InteractorNotImplemented.run(param: '1') }
    end

  end  
end


