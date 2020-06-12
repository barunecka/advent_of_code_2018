class ProcessRecords
  def initialize
    @records = Hash.new
  end

  def call
    parse_file
    sort_records
  end

  private

  attr_accessor :records

  def parse_file
    File.foreach('records.txt') do |record|
      date_and_time = match_date_and_time(record)
      event = match_event(record)
      @records[Time.parse(date_and_time)] = event
    end
  end

  def sort_records
    records.sort
  end

  def match_date_and_time(record)
    record.match(/\[(.+)\]/)[1]
  end

  def match_event(record)
    record.match(/\] (.+)/)[1]
  end
end
