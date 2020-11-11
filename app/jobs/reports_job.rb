class ReportsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    start_date = args[0]
    end_date   = args[1]
    data = AllocationReportGenerator.new.execute(start_date,end_date)
    ReportsMailer.allocations(date: "#{start_date} à #{end_date}", path: data[:path], errors: data[:errors]).deliver
  end
end
