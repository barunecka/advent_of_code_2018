class FindBoxesWithPrototypeFabric
  def initialize(list_of_ids)
    @list_of_ids = list_of_ids
    @two_resulting_ids = Array.new
  end

  def call
    list_of_ids.each do |first_id|
      list_of_ids.each do |second_id|
        unmatched_letters = compare_ids_and_return_unmatched_letters(first_id, second_id)
        add_one_letter_difference_id_to_result(unmatched_letters, first_id)
      end
    end

    common_letters = find_common_letters_between_two_ids
    print_common_letters(common_letters)
  end

  private

  attr_accessor :two_resulting_ids
  attr_reader :list_of_ids

  def compare_ids_and_return_unmatched_letters(first_id, second_id)
    unmatched_letters = []

    first_id.each_with_index do |letter, position|
      if first_id[position] != second_id[position]
        unmatched_letters << letter
      end
    end

    unmatched_letters
  end

  def add_one_letter_difference_id_to_result(unmatched_letters, first_id)
    if unmatched_letters.count == 1
      two_resulting_ids << first_id
    end
  end

  def find_common_letters_between_two_ids
    # program assumes that there are only two ids to compare
    first_id = two_resulting_ids.first
    second_id = two_resulting_ids.last

    first_id.each_with_index do |letter, position|
      if first_id[position] != second_id[position]
        first_id.delete_at(position)
        return first_id
      end
    end
  end

  def print_common_letters(common_letters)
    puts "Common letters for two boxes containing fabric are: #{common_letters.join}"
  end
end
