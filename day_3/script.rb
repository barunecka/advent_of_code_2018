#!/usr/bin/env ruby
require_relative 'no_matter_how_you_slice_it.rb'

input = File.readlines('list.txt')
NoMatterHowYouSliceIt.new(input).call
