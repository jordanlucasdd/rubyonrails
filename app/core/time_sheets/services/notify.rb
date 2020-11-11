module TimeSheets

  class Services::Notify

    def initialize(ts)
      @ts = Repositories::TimeSheets.new.get(ts.id)
    end

    def exec
      if @ts.status == STATUS::WAITING_APPROVAL
        TimeSheetNotificationMailer.request_approval(@ts.id).deliver
        # TimeSheetNotificationMailer.request_approval(@ts.id).deliver_later
      elsif  @ts.status == STATUS::DISAPPROVED
        TimeSheetNotificationMailer.disapproval(@ts.id).deliver
        # TimeSheetNotificationMailer.disapproval(@ts.id).deliver_later
      end
        
    end

  end

end