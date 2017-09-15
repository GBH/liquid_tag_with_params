require 'liquid'
require_relative 'liquid_tag_with_params/parser'

class Liquid::TagWithParams < Liquid::Tag

  attr_reader :params

  def initialize(tag_name, markup, parse_context)
    super
    @params = LiquidTagWithParams::Parser.parse(markup)
  end

  def render(_context)
    ""
  end
end
