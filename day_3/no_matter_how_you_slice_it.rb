class NoMatterHowYouSliceIt
  def initialize(list_of_claims)
    @list_of_claims = list_of_claims
    @coordinates_without_duplicates = Hash.new
    @duplicate_coordinates = Hash.new
  end

  def call
    duplicate_coordinates_count
    print_duplicate_coordinates_count
    non_overlapping_claim
  end

  private

  attr_accessor :coordinates_without_duplicates, :duplicate_coordinates, :non_overlapping_claim
  attr_reader :list_of_claims

  def duplicate_coordinates_count
    list_of_claims.each do |claim|
      claim_coordinates = create_coordinates(claim)
      sort_duplicate_and_standard_coordinates(claim_coordinates)
    end
  end

  def print_duplicate_coordinates_count
    puts "There are #{duplicate_coordinates.count} square inches of fabric within two or more claims."
  end

  def non_overlapping_claim
    non_overlapping_claim = Array.new

    list_of_claims.each do |claim|
      claim_coordinates = create_coordinates(claim)

      unless contains_duplicate?(claim_coordinates)
        non_overlapping_claim << claim
      end
    end

    print_non_overlapping_claim(non_overlapping_claim)
  end

  def create_coordinates(claim)
    first_coordinate_y_axis, first_coordinate_x_axis, width, height = split_claim(claim)
    generate_coordinates_for_one_claim(first_coordinate_y_axis, first_coordinate_x_axis, width, height)
  end

  def print_non_overlapping_claim(non_overlapping_claim)
    puts "Non-overlapping claim id is #{non_overlapping_claim.first.match(/#(\d{1,}) /)[1]}."
  end

  def split_claim(claim)
    first_coordinate_y_axis = claim.match(/ (\d{1,}),/)[1].to_i
    first_coordinate_x_axis = claim.match(/,(\d{1,}):/)[1].to_i
    width = claim.match(/ (\d{1,})x/)[1].to_i
    height = claim.match(/x(\d{1,})/)[1].to_i

    [first_coordinate_y_axis, first_coordinate_x_axis, width, height]
  end

  def generate_coordinates_for_one_claim(first_coordinate_y_axis, first_coordinate_x_axis, width, height)
    coordinates = []

    height.times do |height_number|
      width.times do |width_number|
        coordinates << [
          (width_number != 0 ? first_coordinate_y_axis + width_number : first_coordinate_y_axis),
          (height_number != 0 ? first_coordinate_x_axis + height_number : first_coordinate_x_axis)
        ]
      end
    end

    coordinates
  end

  def sort_duplicate_and_standard_coordinates(coordinates)
    coordinates.each do |coordinate|
      if coordinates_without_duplicates.key?(coordinate)
        # I need hash for better performance but I don't really care about value
        duplicate_coordinates[coordinate] = "some_fake_value"
      end

      coordinates_without_duplicates[coordinate] = "some_fake_value"
    end
  end

  def contains_duplicate?(coordinates)
    claim_contains_duplicate = false

    coordinates.each do |coordinate|
      if duplicate_coordinates.key?(coordinate)
        claim_contains_duplicate = true
      end
    end

    claim_contains_duplicate
  end
end
