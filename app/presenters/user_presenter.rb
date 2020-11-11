class UserPresenter < BasePresenter

  attr_reader :id, :first_name, :name, :email

  def initialize(user)
    @user = user
    @id = user.id
    @name = get_name(user)
    @first_name = @name.split(' ')[0] || "" if @name
    @email = user.email
    @avatar_url = user.avatar
    @avatar_timer = Time.now.to_i
  end


  def is_admin?
    @user.roles.include? 'ADMIN'
  end

  def recent_projects
    @user.recent_projects || []
  end

  def is_manager?
    if @is_manager.nil?
      @is_manager = (Projects::Repositories::Projects.new.by_responsible(@user).count > 0)
    end

    @is_manager
  end

  def avatar
    begin
      if @avatar_timer < (Time.now.to_i + 5)
        @avatar_url = EloS3.new.get(@user.avatar)
        @avatar_timer = (Time.now.to_i + 60)
      end
    rescue Exception => e
      @avatar_url =  asset("avatar-placeholder.png")
    end

    @avatar_url
  end

  private
    def get_name(user)
      return user.email if user.name.nil?
      return user.email if user.name.strip == ""
      return user.name
    end




end