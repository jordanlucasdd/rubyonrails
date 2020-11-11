module Projects
  class Domain::Collaborator

    attr_accessor :id, :name, :email, :permissions

    def can_write?
      self.permissions.include? COLLABORATOR::PERMISSION::WRITE
    end

    def can_approve?
      self.permissions.include? COLLABORATOR::PERMISSION::APPROVE
    end

    def can_read?
      self.permissions.include? COLLABORATOR::PERMISSION::READ
    end

  end
end