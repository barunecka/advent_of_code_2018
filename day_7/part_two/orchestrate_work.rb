class OrchestrateWork
  def initialize(steps, workers)
    @steps = steps
    @workers = workers
    @time = 0
  end

  def call
    workers.create_workers

    while steps.not_finished? do
      assign_available_workers_to_work(workers)

      move_time_to_worker_finishing_first(workers)

      manage_finished_work(workers)
    end

    output_result
  end

  private

  attr_accessor :steps, :workers, :time

  def output_result
    puts "It takes #{time} seconds to finish all the steps."
  end

  def assign_available_workers_to_work(workers)
    workers.workers_collection.each do |worker|
      if worker.available? && steps.next_step_available?
        start_work_on_new_step(steps, worker)
      end
    end
  end

  def start_work_on_new_step(steps, worker)
    next_step = steps.next_step
    duration_of_step = steps.step_duration(next_step)
    worker.assign_step(next_step, duration_of_step, time)
    steps.remove_step(next_step)
  end

  def workers_finishing_times(workers)
    workers.workers_collection.map do |worker|
      worker.finishing_time
    end
  end

  def move_time_to_worker_finishing_first(workers)
    finishing_times = workers_finishing_times(workers)

    unless finishing_times.compact.empty?
      @time = finishing_times.compact.sort.first
    end
  end

  def manage_finished_work(workers)
    workers.workers_collection.each do |worker|
      if worker.finishing_time == time
        steps.add_step_to_finished_steps(worker.working_on)
        steps.remove_prerequisite(worker.working_on)
        worker.reset_worker
      end
    end
  end
end
