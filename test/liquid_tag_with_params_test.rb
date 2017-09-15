require_relative 'test_helper'

class LiquidTagWithParamsTest < MiniTest::Test
  include Liquid

  def test_initialization
    params = "param_1, param_2, key_1: val_1, key_2: val_2"
    tag = Liquid::TagWithParams.send(:new, 'test_tag', params, ParseContext.new)

    assert_equal 'test_tag', tag.tag_name
    assert_equal params, tag.instance_variable_get("@markup")
    assert_equal ['param_1', 'param_2', {'key_1' => 'val_1', 'key_2' => 'val_2'}],
      tag.params
  end
end