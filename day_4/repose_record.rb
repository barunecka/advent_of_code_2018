class ReposeRecord
  def initialize(sorted_records)
    @sorted_records = sorted_records
    @minutes_asleep_per_each_guard = Hash.new
  end

  def call
    generate_times_asleep_per_guard

    sleepiest_guard_id = top_sleeper_guard_id
    top_minutes_slept = top_minute_slept_with_count_per_guard_id

    output_first_part_result(
      sleepiest_guard_id_multiplied_by_sleepiest_minute(sleepiest_guard_id, top_minutes_slept)
    )

    output_second_part_result(
      find_guard_with_minute_spent_asleep_most(top_minutes_slept)
    )
  end

  private

  attr_reader :sorted_records
  attr_accessor :minutes_asleep_per_each_guard

  def generate_times_asleep_per_guard
    sleep_start_time = nil
    sleep_start_minute = nil
    guard_id = nil

    sorted_records.each do |record|
      #Example for sorted record: [1518-01-28 00:00:00 +1200, "Guard #151 begins shift"]
      if guard_starts_shift?(record)
        guard_id = get_guard_id(record)
      elsif guard_falls_asleep?(record)
        sleep_start_time = get_sleep_time(record)
      elsif guard_wakes_up?(record)
        sleep_end_time = get_sleep_time(record)

        minutes_asleep(guard_id, sleep_start_time, sleep_end_time)
      end
    end
  end

  def minutes_asleep(guard_id, sleep_start_time, sleep_end_time)
    if minutes_asleep_per_each_guard.key?(guard_id)
      minutes_asleep_per_each_guard[guard_id] += (sleep_start_time.min..sleep_end_time.min - 1).to_a
    else
      minutes_asleep_per_each_guard[guard_id] = (sleep_start_time.min..sleep_end_time.min - 1).to_a
    end
  end

  def guard_starts_shift?(record)
    record.last.include?('Guard')
  end

  def guard_falls_asleep?(record)
    record.last.include?('falls')
  end

  def guard_wakes_up?(record)
    record.last.include?('wakes')
  end

  def get_guard_id(record)
    record.last.match(/\d+/).to_s
  end

  def get_sleep_time(record)
    record.first
  end

  def top_sleeper_guard_id
    # what a fancy way how to do something like map with hash result. Had to try it, sorry :)
    minutes_asleep_per_each_guard
      .inject({}) { |hash, (key, value)| hash[key] = value.size; hash }
      .sort_by { |key, value| value }.last.first
  end

  def top_minute_slept_with_count_per_guard_id
    minutes_slept = Hash.new

    minutes_asleep_per_each_guard.each do |guard, minutes|
      sixty_minutes_representation = Hash[(0..59).map { |num| [num, 0] }]

      minutes.each do |minute|
        sixty_minutes_representation[minute] += 1
      end

      minutes_slept[guard] = sixty_minutes_representation.sort_by { |minute, amount| amount }.last
    end

    minutes_slept
  end

  def sleepiest_guard_id_multiplied_by_sleepiest_minute(sleepiest_guard_id, top_minutes_slept)
    sleepiest_guard_id.to_i * top_minutes_slept[sleepiest_guard_id].first
  end

  def find_guard_with_minute_spent_asleep_most(top_minute_slept_with_amount)
    resulting_guard_with_minutes = top_minute_slept_with_amount.sort_by { |guard_id, collection| collection.last }.last.flatten
    resulting_guard_with_minutes[0].to_i * resulting_guard_with_minutes[1]
  end

  def output_first_part_result(number)
    puts "ID of the sleepiest guard multiplied by the minute he spent asleep most is #{number}."
  end

  def output_second_part_result(number)
    puts "ID of the guard most frequently asleep on the same minute multiplied by the minute is #{number}."
  end
end
