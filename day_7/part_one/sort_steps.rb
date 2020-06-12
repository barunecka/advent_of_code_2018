class SortSteps
  def initialize(steps_with_prerequisites)
    @steps_with_prerequisites = steps_with_prerequisites
    @sorted_steps = Array.new
  end

  def call
    steps_with_prerequisites.length.times do |position|
      all_available_steps = steps_available(position + 1)
      next_step = first_available_step_alphabetically(all_available_steps)

      remove_from_steps(next_step)
      remove_from_prerequisites(next_step)

      sorted_steps << next_step
    end

    output_result(sorted_steps.join)
  end

  private

  attr_accessor :steps_with_prerequisites, :sorted_steps

  def remove_from_steps(step)
    steps_with_prerequisites.delete(step)
  end

  def remove_from_prerequisites(prerequisite)
    steps_with_prerequisites.each do |step, prerequisites|
      prerequisites.delete(prerequisite) if prerequisites.include?(prerequisite)
    end
  end

  def steps_available(position)
    steps_available = Array.new

    steps_with_prerequisites.each do |step, prerequisites|
      steps_available << step if prerequisites.empty?
    end

    steps_available
  end

  def first_available_step_alphabetically(available_steps)
    available_steps.sort.first
  end

  def output_result(sorted_steps)
    puts "Steps should be completed in the following order #{sorted_steps}."
  end
end
