class Workers
  attr_accessor :workers_collection

  def initialize(count_of_workers)
    @count_of_workers = count_of_workers
    @workers_collection = Array.new
  end

  def create_workers
    (1..count_of_workers).each do |worker|
      workers_collection << Worker.new
    end
  end

  private

  attr_reader :count_of_workers
end
