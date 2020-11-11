class UserProfilesController < ApplicationController

  def show
    user = UserPresenter.new(User.find(params[:id]))
    dto = {
      id: user.id,
      name: user.name,
      first_name: user.first_name,
      email: user.email,
      avatar_url: user.avatar
    }

    render json: dto
  end
  
end