class RootNodeValue
  def initialize(nodes)
    @nodes = nodes
  end

  def call
    calculate_node_value_for_childless_nodes

    calculate_node_value_for_nodes_with_children

    output_result(root_node_value)
  end

  private

  attr_accessor :nodes

  def root_node_value
    nodes.all_nodes[0].node_value
  end

  def calculate_node_value_for_childless_nodes
    nodes.all_nodes.each do |node|
      if !node.has_kids?
        node.node_value = node.metadata_content.reduce(:+)
      end
    end
  end

  def calculate_node_value_for_nodes_with_children
    while root_node_value.nil? do
      nodes.all_nodes.each do |node|
        next unless node.node_value.nil?

        if all_kids_have_node_value?(node)
          node.node_value = sum_of_childnode_values(node)
        end
      end
    end
  end

  def sum_of_childnode_values(node)
    node.metadata_content.map do |number|
      if !node.kids_finished[number - 1].nil?
        node.kids_finished[number - 1].node_value
      else
        0
      end
    end.reduce(:+)
  end

  def all_kids_have_node_value?(node)
    result = true

    node.kids_finished.each do |kid|
      if kid.node_value.nil?
        result = false
        break
      end
    end

    result
  end

  def output_result(root_node_value)
    puts "Value of the root node is #{root_node_value}."
  end
end
