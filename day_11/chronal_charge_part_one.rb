class ChronalChargePartOne
  def initialize
    @coordinates_list_with_fuel_power = Hash.new
    @coordinates_list = Array.new
    @coordinates_with_overall_power = Hash.new
  end

  attr_reader :coordinates_list, :coordinates_list_with_fuel_power, :coordinates_with_overall_power

  GRID = 300
  SQUARE_SIZE = 3

  def call
    create_coordinates
    create_coordinates_list_with_fuel_cell_power

    find_overall_power_level_for_squares

    result = find_coordinate_with_max_overall_power
    output_result(result)
  end

  def create_coordinates_list_with_fuel_cell_power
    (1..GRID).each do |y|
      (1..GRID).each do |x|
        fuel_cell = FuelCell.new(x, y).generate_power_level
        coordinates_list_with_fuel_power[[x, y]] = fuel_cell
      end
    end
  end

  def create_coordinates
    # 3x3 square must be entirely within the 300x300 grid
    # This is why we don't want to use GRID value (300) only, but 288
    (1..GRID - SQUARE_SIZE + 1).each do |y|
      (1..GRID - SQUARE_SIZE + 1).each do |x|
        coordinates_list << [x, y]
      end
    end
  end

  def find_square_per_coordinate(square_size, coordinate)
    x_coordinate = coordinate.first
    y_coordinate = coordinate.last
    coordinates = Array.new

    square_size.times do |y|
      square_size.times do |x|
        coordinates <<
        [
          x == 0 ? x_coordinate : x_coordinate + x,
          y == 0 ? y_coordinate : y_coordinate + y
        ]
      end
    end

    coordinates
  end

  def find_overall_power_level_for_squares
    coordinates_list.each do |coordinate|
      overall_power_level = 0
      square_coordinates = find_square_per_coordinate(SQUARE_SIZE, coordinate)

      square_coordinates.each do |square_coordinate|
        overall_power_level += coordinates_list_with_fuel_power[square_coordinate]
      end

      coordinates_with_overall_power[coordinate] = overall_power_level
    end
  end

  def find_coordinate_with_max_overall_power
    maximum_value = 0
    coordinates = Array.new

    coordinates_with_overall_power.each do |coordinate, power|
      if power > maximum_value
        maximum_value = power
        coordinates = coordinate
      end
    end

    coordinates
  end

  def output_result(result)
    puts "X,Y coordinate of the top-left fuel cell of the #{SQUARE_SIZE}x#{SQUARE_SIZE} square with the largest total power is #{result}."
  end
end
