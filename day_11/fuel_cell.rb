class FuelCell
  def initialize(x_coordinate, y_coordinate)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
  end

  GRID_SERIAL_NUMBER = 7315

  def generate_power_level
    fuel_cell_rack_id = x_coordinate + 10

    starting_power_level = fuel_cell_rack_id * y_coordinate

    increased_power_level = starting_power_level + GRID_SERIAL_NUMBER

    power_level_times_rack_id = increased_power_level * fuel_cell_rack_id

    power_level = find_hundreds_digit(power_level_times_rack_id)

    power_level -= 5
  end

  private

  attr_reader :x_coordinate, :y_coordinate

  def find_hundreds_digit(number)
    if number.to_s.length < 3
      0
    else
      number.to_s.reverse[2].to_i
    end
  end
end
