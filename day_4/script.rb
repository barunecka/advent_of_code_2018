#!/usr/bin/env ruby
require_relative 'process_records.rb'
require_relative 'repose_record.rb'
require 'time'

sorted_records = ProcessRecords.new.call
ReposeRecord.new(sorted_records).call
