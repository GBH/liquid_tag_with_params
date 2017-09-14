$:.unshift File.expand_path('../lib', __FILE__)
require 'liquid/tag_with_params/version'

Gem::Specification.new do |s|
  s.name          = "liquid_tag_with_params"
  s.version       = LiquidTagWithParams::VERSION
  s.authors       = ["Oleg Khabarov"]
  s.email         = ["oleg@khabarov.ca"]
  s.homepage      = "http://github.com/comfy/liquid_tag_with_params"
  s.summary       = "Liquid::TagWithParams"
  s.description   = "Tag class for Liquid markup that supports extra params"

  s.files         = `git ls-files`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']

  s.add_dependency 'liquid', ">= 4.0.0"
end