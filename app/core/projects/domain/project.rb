module Projects

  class Domain::Project

    attr_accessor :id, :name, :collaborators, :cost_center, :responsible_for_approval_id, :gfp_id


    def manager
      if @responsible.nil?
        begin
          # dto = Intranet::Profile.new.get(@responsible_for_approval_id)
          dto = User.find @responsible_for_approval_id
          first_name = dto.name.split(' ')[0] || ""
          @responsible = OpenStruct.new(id: dto.id, email: dto.email, name: dto.name, first_name: first_name)
        rescue Exception => e
          @responsible = OpenStruct.new(id: nil, email: nil, name: nil, first_name: nil)
        end
      end

      @responsible
    end

  end

end