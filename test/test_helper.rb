require 'bundler/setup'
require 'minitest/autorun'
require 'liquid_tag_with_params'

class MiniTest::Test

  # Example usage:
  #   assert_exception_raised                                 do ... end
  #   assert_exception_raised ActiveRecord::RecordInvalid     do ... end
  #   assert_exception_raised Plugin::Error, 'error_message'  do ... end
  def assert_exception_raised(exception_class = nil, error_message = nil, &block)
    exception_raised = nil
    yield
  rescue => exception_raised
  ensure
    if exception_raised
      if exception_class
        assert_equal exception_class, exception_raised.class, exception_raised.to_s
      else
        assert true
      end
      assert_equal error_message, exception_raised.to_s if error_message
    else
      flunk 'Exception was not raised'
    end
  end

end
