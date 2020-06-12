class Worker
  attr_accessor :finishing_time, :available, :working_on

  def initialize
     @finishing_time = nil
     @available = true
     @working_on = nil
  end

  def assign_step(next_step, duration_of_step, current_time)
    @finishing_time = current_time + duration_of_step
    @available = false
    @working_on = next_step
  end

  def reset_worker
    @finishing_time = nil
    @available = true
    @working_on = nil
  end

  def available?
    available == true
  end
end
