#!/usr/bin/env ruby
require_relative 'create_list_of_steps_with_prerequisites.rb'
require_relative 'sort_steps.rb'

steps_with_prerequisites = CreateListOfStepsWithPrerequisites.new.call

SortSteps.new(steps_with_prerequisites).call
