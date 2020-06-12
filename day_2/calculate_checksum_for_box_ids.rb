class CalculateChecksumForBoxIds
  def initialize(list_of_ids)
    @list_of_ids = list_of_ids
    @two_letter_id_boxes = Array.new
    @three_letter_id_boxes = Array.new
  end

  def call
    sort_boxes_by_id

    print_checksum(calculate_checksum)
  end

  private

  attr_accessor :list_of_ids, :two_letter_id_boxes, :three_letter_id_boxes

  def sort_boxes_by_id
    list_of_ids.each do |word|
      box_id = BoxId.new(word)

      three_letter_id_boxes << word if box_id.contains_threes?

      two_letter_id_boxes << word if box_id.contains_twos?
    end
  end

  def calculate_checksum
    three_letter_id_boxes.count * two_letter_id_boxes.count
  end

  def print_checksum(checksum)
    puts "Checksum for current list of box IDs is: #{checksum}"
  end
end
