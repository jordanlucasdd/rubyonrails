module Users
  class Domain::Employee

    attr_accessor :id, :name, :function, :level, :role, :hiring_date, :dismissal_date, :contract_type, :unit, :office

    def is_out?
      (self.dismissal_date != nil)
    end

  end
end