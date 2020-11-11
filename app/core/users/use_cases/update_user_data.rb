module Users
  class UseCases::UpdateUserData

    def initialize(user)
      @user = user
    end

    def execute
      
      begin
        dto = Intranet::Profile.new.get_by_email(@user.email)
        @user.name = dto['name']
        @user.avatar = dto['avatar']
        @user.save
      rescue Exception => e
        p e.message
      end
      
    end

  end
end