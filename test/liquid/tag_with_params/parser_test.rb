require_relative '../../test_helper'

class Liquid::TagWithParams::ParserTest < MiniTest::Test

  def test_tokenizer
    tokens = LiquidTagWithParams::Parser.tokenize("param")
    assert_equal [[:string, "param"]], tokens
  end

  def test_tokenizer_with_commas
    tokens = LiquidTagWithParams::Parser.tokenize("param_a, param_b")
    assert_equal [[:string, "param_a"], [:comma, ","], [:string, "param_b"]], tokens
  end

  def test_tokenizer_with_columns
    tokens = LiquidTagWithParams::Parser.tokenize("key: value")
    assert_equal [[:string, "key"], [:column, ":"], [:string, "value"]], tokens
  end

  def test_tokenizer_with_quoted_value
    tokens = LiquidTagWithParams::Parser.tokenize("key: 'v1, v2: v3'")
    assert_equal [[:string, "key"], [:column, ":"], [:string, "'v1, v2: v3'"]], tokens

    tokens = LiquidTagWithParams::Parser.tokenize('key: "v1, v2: v3"')
    assert_equal [[:string, "key"], [:column, ":"], [:string, '"v1, v2: v3"']], tokens
  end

  def test_tokenizer_with_bad_input
    assert_exception_raised do
      LiquidTagWithParams::Parser.tokenize("%")
    end
  end

  def test_slice
    tokens = [[:string, "a"], [:comma, ","], [:string, "b"]]
    token_groups = LiquidTagWithParams::Parser.slice(tokens)
    assert_equal [[[:string, "a"]], [[:string, "b"]]], token_groups
  end

  def test_parameterize
    token_groups = [[[:string, "a"]]]
    params = LiquidTagWithParams::Parser.parameterize(token_groups)
    assert_equal ["a"], params

    token_groups = [[[:string, "a"], [:column, ":"], [:string, "b"]]]
    params = LiquidTagWithParams::Parser.parameterize(token_groups)
    assert_equal [{"a" => "b"}], params
  end

  def test_parameterize_with_bad_input
    token_groups = [[[:string, "a"], [:string, "b"]]]
    assert_exception_raised do
      LiquidTagWithParams::Parser.parameterize(token_groups)
    end
  end

  def test_collect_param_for_string!
    params = []
    LiquidTagWithParams::Parser.collect_param_for_string!(params, [:string, "a"])
    assert_equal ["a"], params
  end

  def test_collect_param_for_string_with_bad_input
    assert_exception_raised do
      LiquidTagWithParams::Parser.collect_param_for_string!([], [:invalid, "a"])
    end
  end

  def test_collect_param_for_hash!
    params = []
    tokens = [[:string, "a"], [:column, ":"], [:string, "b"]]
    LiquidTagWithParams::Parser.collect_param_for_hash!(params, tokens)
    assert_equal [{"a" => "b"}], params
  end

  def test_collect_param_for_hash_with_trailing_hash
    params = ["x", {"y" => "z"}]
    tokens = [[:string, "a"], [:column, ":"], [:string, "b"]]
    LiquidTagWithParams::Parser.collect_param_for_hash!(params, tokens)
    assert_equal ["x", {"y" => "z", "a" => "b"}], params
  end

  def test_collect_param_for_hash_with_trailing_param
    params = ["x", {"y" => "z"}, "k"]
    tokens = [[:string, "a"], [:column, ":"], [:string, "b"]]
    LiquidTagWithParams::Parser.collect_param_for_hash!(params, tokens)
    assert_equal ["x", {"y" => "z"}, "k", {"a" => "b"}], params
  end

  def test_collect_param_for_hash_with_bad_input
    assert_exception_raised do
      tokens = [[:string, "a"], [:invalid, ":"], [:string, "b"]]
      LiquidTagWithParams::Parser.collect_param_for_hash!([], tokens)
    end
  end

  def test_parse
    text = "param_a, param_b, key_a: val_a, key_b: val_b, param_c, key_c: val_c"
    params = LiquidTagWithParams::Parser.parse(text)
    assert_equal [
      "param_a",
      "param_b",
      {"key_a" => "val_a", "key_b" => "val_b"},
      "param_c",
      {"key_c" => "val_c"}
    ], params
  end
end
