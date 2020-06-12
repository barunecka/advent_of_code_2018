class Steps
  def initialize(steps_with_prerequisites)
    @steps_with_prerequisites = steps_with_prerequisites
    @total_step_count = steps_with_prerequisites.length
    @finished_steps = Array.new
  end

  def not_finished?
    total_step_count != finished_steps.length
  end

  def next_step_available?
    available = false

    steps_with_prerequisites.each do |step, prerequisite|
      if prerequisite.empty?
        available = true
        break
      end
    end

    available
  end

  def next_step
    available_steps = Array.new

    steps_with_prerequisites.each do |step, prerequisite|
      if prerequisite.empty?
        available_steps << step
      end
    end

    available_steps.sort.first
  end

  def step_duration(step)
    duration_of_each_step[step]
  end

  def add_step_to_finished_steps(step)
    finished_steps << step
  end

  def remove_step(step)
    steps_with_prerequisites.delete(step)
  end

  def remove_prerequisite(prerequisite_to_be_removed)
    steps_with_prerequisites.each do |step, prerequisite|
      if prerequisite.include?(prerequisite_to_be_removed)
        prerequisite.delete(prerequisite_to_be_removed)
      end
    end
  end

  private

  attr_accessor :steps_with_prerequisites, :finished_steps
  attr_reader :total_step_count

  def duration_of_each_step
    # {"A"=>61, "B"=>62, "C"=>63,...}
    additional_time = 0

    duration_of_steps = Hash[
      ('A'..'Z').to_a.map do |step|
        additional_time += 1
        [step, 60 + additional_time]
      end
    ]
  end
end
