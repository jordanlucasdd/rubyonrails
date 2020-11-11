module TimeSheets

  class UseCases::Approve

    def initialize(user_id:, ts_id:, approve:)
      @user_id = user_id
      @ts_id = ts_id
      @approve = approve
      @rep = TimeSheets::Repositories::TimeSheets.new
    end

    def execute
      ts = @rep.get(@ts_id)
      if @approve
        ts.status = STATUS::APPROVED
        ts.approved_at = Time.zone.now
      else
        ts.status = STATUS::DISAPPROVED
        ts.reproved_at = Time.zone.now
      end

      @rep.save(ts)
    end

  end

end