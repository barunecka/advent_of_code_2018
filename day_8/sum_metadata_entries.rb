class SumMetadataEntries
  def initialize(nodes)
    @nodes = nodes
  end

  def call
    all_metadata = nodes.all_nodes.map do |node|
      node.metadata_content
    end.flatten!

    output_result(all_metadata.inject(:+))
  end

  private

  attr_accessor :nodes

  def output_result(result)
    puts "Sum of all metadata entries is #{result}."
  end
end
