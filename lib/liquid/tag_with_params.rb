require 'liquid'

class Liquid::TagWithParams < Liquid::Tag

  attr_reader :params

  def initialize(tag_name, markup, parse_context)
    super
    @params = Liquid::TagWithParams::Parser.parse(markup)
  end

  def render(_context)
    ""
  end
end

require_relative 'tag_with_params/parser'
