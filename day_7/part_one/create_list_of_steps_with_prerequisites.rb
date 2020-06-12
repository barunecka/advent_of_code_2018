class CreateListOfStepsWithPrerequisites
  def initialize
    @steps_with_prerequisites = Hash.new
  end

  def call
    File.foreach('step_instructions.txt') do |rule|
      add_prerequisite_to_step(step(rule), prerequisite_step(rule))

      create_step_from_prerequisite(prerequisite_step(rule))
    end

    steps_with_prerequisites
  end

  private

  attr_accessor :steps_with_prerequisites

  def create_step_from_prerequisite(prerequisite)
    unless steps_with_prerequisites.key?(prerequisite)
      steps_with_prerequisites[prerequisite] = []
    end
  end

  def step(rule)
    rule.to_s[36]
  end

  def prerequisite_step(rule)
    rule.to_s[5]
  end

  def add_prerequisite_to_step(step, prerequisite)
    if steps_with_prerequisites.key?(step)
      steps_with_prerequisites[step] << prerequisite
    else
      steps_with_prerequisites[step] = [prerequisite]
    end
  end
end
