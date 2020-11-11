class SyncProjectsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    SyncProjects.new.execute
  end
end
