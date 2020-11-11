module TimeSheets

  class UseCases::Cancel

    def initialize(user_id:, ts_id:)
      @user_id = user_id
      @ts_id = ts_id
      @rep = TimeSheets::Repositories::TimeSheets.new
    end

    def execute
      ts = @rep.get(@ts_id)
      @rep.destroy(ts)
      
      ts
    end

  end

end