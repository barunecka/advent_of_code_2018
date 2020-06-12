class ChronalChargePartTwo
  def initialize
    @coordinates_list_with_fuel_power = Hash.new
    @coordinates_list_with_overall_power = Hash.new
    @maximum_power = 0
  end

  GRID = 300

  def call
    generate_coordinate_lists

    (1..GRID).each do |square_size|
      delete_coordinates_that_cannot_form_square_within_grid(square_size) # last row and last column of coordinates in the grid

      find_overall_powers(square_size)

      find_max_power_level_and_coordinate(square_size)
    end

    output_result
  end

  private

  attr_accessor :coordinates_list_with_fuel_power, :coordinates_list_with_overall_power, :maximum_power, :coordinates_for_max_power, :square_size

  def generate_coordinate_lists
    (1..GRID).each do |y|
      (1..GRID).each do |x|
        fuel_cell = FuelCell.new(x, y).generate_power_level
        coordinates_list_with_fuel_power[[x, y]] = fuel_cell
        coordinates_list_with_overall_power[[x, y]] = fuel_cell
      end
    end
  end

  def find_overall_powers(square_size)
    return if square_size == 1

    coordinates_list_with_overall_power.each do |coordinate, overall_power_level|
      square_coordinates = find_surplus_square_coordinates(coordinate, square_size) # we only want surplus coordinates as we will use original overall power from previous square plus only the new coordinates otherwise the script takes even longer to run

      square_coordinates.each do |square_coordinate|
        overall_power_level += coordinates_list_with_fuel_power[square_coordinate]
      end

      coordinates_list_with_overall_power[coordinate] = overall_power_level
    end
  end

  def find_surplus_square_coordinates(coordinate, square_size)
    x_coordinate = coordinate.first
    y_coordinate = coordinate.last
    coordinates = Array.new

    square_size.times do |y|
      coordinates << [x_coordinate + square_size - 1, (y == 0 ? y_coordinate : y_coordinate + y)]
    end

    (square_size - 1).times do |x|
      coordinates << [(x == 0 ? x_coordinate : x_coordinate + x), y_coordinate + square_size - 1]
    end

    coordinates
  end

  def delete_coordinates_that_cannot_form_square_within_grid(square_size)
    return if square_size == 1

    total = GRID + 2 - square_size
    unnecessary_coordinate = GRID + 2 - square_size

    (1..total).each do |coordinate_number|
      coordinates_list_with_overall_power.delete([unnecessary_coordinate, coordinate_number])
      coordinates_list_with_overall_power.delete([coordinate_number, unnecessary_coordinate])
      # one is shared, may be there twice, should not matter
    end
  end

  def find_max_power_level_and_coordinate(square_size)
    coordinates_list_with_overall_power.each do |coordinate, power|
      if power > maximum_power
        @maximum_power = power
        @coordinates_for_max_power = coordinate
        @square_size = square_size
      end
    end
  end

  def output_result
    puts "X, Y, size identifier of the square with the largest total power is #{coordinates_for_max_power}, #{square_size}."
  end
end
