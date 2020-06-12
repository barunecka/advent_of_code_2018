class Node
  def initialize(kids, parent, name)
    @kids = kids
    @parent = parent
    @name = name
    @metadata_amount = nil
    @metadata_content = Array.new
    @node_value = nil
    @kids_finished = Array.new
  end

  attr_reader :parent, :name
  attr_accessor :metadata_amount, :metadata_content, :node_value, :kids_finished

  def add_metadata_amount(amount)
    @metadata_amount = amount
  end

  def add_metadata_content(content)
    metadata_content << content
  end

  def kids_completed?
    kids == 0 ||
      (
        !kids_finished.empty? &&
          kids == kids_finished.uniq.length
      )
  end

  def waiting_for_metadata_amount?
    metadata_amount == nil
  end

  def has_kids?
    kids > 0
  end

  def in_progress?
    waiting_for_metadata_amount? ||
      !kids_completed? ||
      waiting_for_metadata_content?
  end

  def waiting_for_kids_to_complete?
    in_progress? && has_kids? && !kids_completed?
  end

  private

  attr_reader :kids

  def waiting_for_metadata_content?
    metadata_amount > 0 && metadata_content.empty? ||
      (metadata_amount > 0 && metadata_content.length < metadata_amount)
  end
end
