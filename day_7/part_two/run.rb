#!/usr/bin/env ruby
require_relative 'create_list_of_steps_with_prerequisites.rb'
require_relative 'sort_steps.rb'
require_relative 'steps.rb'
require_relative 'worker.rb'
require_relative 'workers.rb'
require_relative 'orchestrate_work.rb'

steps_with_prerequisites = CreateListOfStepsWithPrerequisites.new.call
sorted_steps_with_prerequisites = SortSteps.new(steps_with_prerequisites).call

OrchestrateWork.new(
  Steps.new(sorted_steps_with_prerequisites),
  Workers.new(5)
).call
