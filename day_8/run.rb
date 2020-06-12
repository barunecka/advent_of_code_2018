#!/usr/bin/env ruby
require_relative 'read_input.rb'
require_relative 'node.rb'
require_relative 'nodes.rb'
require_relative 'sum_metadata_entries.rb'
require_relative 'root_node_value.rb'

input = ReadInput.new.call
nodes = Nodes.new(input)
nodes.call

SumMetadataEntries.new(nodes).call
RootNodeValue.new(nodes).call
