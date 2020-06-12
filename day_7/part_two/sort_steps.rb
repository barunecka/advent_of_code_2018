class SortSteps
  def initialize(steps_with_prerequisites)
    @steps_with_prerequisites = steps_with_prerequisites
    @sorted_steps = Hash.new
    @steps_with_prerequisites_not_modified = Marshal.load(Marshal.dump(steps_with_prerequisites))
    # Don't have a better idea for deep clone (I will eventually modify steps_with_prerequisites but I still want the original list accessible).
  end

  def call
    steps_with_prerequisites.length.times do |position|
      all_available_steps = steps_available(position + 1)
      next_step = first_available_step_alphabetically(all_available_steps)

      remove_from_steps(next_step)
      remove_from_prerequisites(next_step)

      sorted_steps[next_step] = steps_with_prerequisites_not_modified[next_step]
    end

    sorted_steps
  end

  private

  attr_accessor :steps_with_prerequisites, :sorted_steps
  attr_reader :steps_with_prerequisites_not_modified

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
end
