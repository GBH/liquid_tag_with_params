# Liquid Tag With Params
[![Gem Version](https://img.shields.io/gem/v/liquid_tag_with_params.svg?style=flat)](http://rubygems.org/gems/liquid_tag_with_params) [![Gem Downloads](https://img.shields.io/gem/dt/liquid_tag_with_params.svg?style=flat)](http://rubygems.org/gems/liquid_tag_with_params) [![Build Status](https://img.shields.io/travis/comfy/liquid_tag_with_params.svg?style=flat)](https://travis-ci.org/comfy/liquid_tag_with_params)

This is a `Liquid::TagWithParams` that extends `Liquid::Tag` by adding support for, you guessed it, params.

## Install

Add gem to your Gemfile:

```ruby
gem 'liquid_tag_with_params', '~> 0.0.1'
```

## Usage

This gem is primarily for extending Liquid [by creating your own tags](https://github.com/Shopify/liquid/wiki/Liquid-for-Programmers#create-your-own-tags). Out of the box `Liquid::Tag`
accepts a string and that's about it. `Liquid::TagWithParams` will take that
string and will make parameters out of it so you can use them during rendering.

Here's an example of such tag:

```ruby
require 'liquid/tag_with_params'

class ShuffleTag < Liquid::TagWithParams
  def initialize(tag_name, params, tokens)
     super
  end

  def render(context)
    # assuming that last params were of key: value format
    options = @params.extract_options!

    # note: keys and values are always strings
    times = options["times"] || 1

    # shuffle really hard
    times.to_i.times do
      @params.shuffle!
    end

    @params.join(', ')
  end
end

Liquid::Template.register_tag('shuffle', ShuffleTag)
```

```ruby
@template = Liquid::Template.parse("{% shuffle 1, 2, 3, 4, times: 5 %}")
@template.render    # => "2, 1, 3, 4"
```

---
Copyright 2017, Oleg Khabarov
