module TimeSheets

  class Domain::TimeSheet

    attr_accessor :id, :hours, :percentage, :month, :year, :project, :cost_center, :status, 
                  :user, :reason_for_disapproval, :approved_at, :reproved_at, :canceled_at

    def is_opened?
      self.status == ::STATUS::OPEN
    end

    def is_waiting_for_approval?
      self.status == ::STATUS::WAITING_APPROVAL
    end

    def is_approved?
      self.status == ::STATUS::APPROVED
    end

    def is_disapproved?
      self.status == ::STATUS::DISAPPROVED
    end

  end

end