#!/usr/bin/env ruby
require_relative 'puzzle_input'
require_relative 'calculate_checksum_for_box_ids'
require_relative 'box_id'
require_relative 'find_boxes_with_prototype_fabric'

input = PuzzleInput.new.call

CalculateChecksumForBoxIds.new(input).call
FindBoxesWithPrototypeFabric.new(input).call
