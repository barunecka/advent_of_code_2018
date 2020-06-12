class ChronalCalibration

  def initialize
    @current_frequency = 0
  end

  def call
    retrieve_input
    resulting_frequency_output
    result = first_frequency_reached_twice
    first_frequency_reached_twice_output(result)
  end

  private

  attr_reader :frequency_change_list
  attr_accessor :current_frequency

  def retrieve_input
    @frequency_change_list = File.readlines('input.csv').map(&:to_i)
  end

  def resulting_frequency_output
    puts "Resulting frequency is #{frequency_change_list.reduce(:+)}."
  end

  def first_frequency_reached_twice_output(result)
    puts "First frequency reached twice is #{result}."
  end

  def first_frequency_reached_twice
    resulting_frequencies = Hash.new
    result = nil

    while !result do
      frequency_change_list.each do |frequency|
        if resulting_frequencies.key?(@current_frequency += frequency)
          result = current_frequency
          break
        else
          resulting_frequencies[current_frequency] = true
        end
      end
    end

    result
  end
end
