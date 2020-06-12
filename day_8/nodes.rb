class Nodes
  def initialize(input)
    @input = input
    @all_nodes = Array.new
    @current_node = nil
    @current_parent = nil
  end

  ROOT_NODE = "ROOT"

  attr_accessor :all_nodes

  def call
    input.each do |number|
      if current_node_empty?
        create_new_node_and_add_to_all_nodes(number)
      else
        add_metadata_amount_or_content_to_current_node(number)

        determine_new_current_and_parent_nodes
      end
    end
  end

  private

  attr_accessor :current_node, :current_parent, :node_amount
  attr_reader :input

  def current_node_empty?
    current_node == nil
  end

  def create_new_node_and_add_to_all_nodes(number)
    create_node(number)
    add_node_to_all_nodes
  end

  def create_node(kids_amount)
    parent = current_parent.nil? ? ROOT_NODE : current_parent.name

    @current_node = Node.new(kids_amount, parent, generate_name)
  end

  def add_node_to_all_nodes
    all_nodes << current_node
  end

  def current_node_waiting_for_metadata_amount?
    !current_node.nil? && current_node.waiting_for_metadata_amount?
  end

  def determine_new_current_and_parent_nodes
    if current_node.waiting_for_kids_to_complete?
      @current_parent = current_node
      clear_current_node
    else
      choose_next_current_node_and_current_parent
    end
  end

  def choose_next_current_node_and_current_parent
    while (!current_node.nil? && !current_node.in_progress?) do
      if current_node.parent == "ROOT"
        break
      end

      current_parent.kids_finished << current_node

      if current_parent.has_kids? && !current_parent.kids_completed?
        clear_current_node
      else
        @current_node = current_parent
        @current_parent = find_parent
      end
    end
  end

  def add_metadata_amount_or_content_to_current_node(number)
    if current_node_waiting_for_metadata_amount?
      current_node.add_metadata_amount(number)
    else
      current_node.add_metadata_content(number)
    end
  end

  def find_parent
    parent_node = nil

    all_nodes.each do |node|
      if current_node.parent == node.name
        parent_node = node
      end
    end

    parent_node
  end

  def clear_current_node
    @current_node = nil
  end

  def generate_name
    @node_amount ||= 0
    @node_amount += 1
    "node_#{node_amount}"
  end
end
