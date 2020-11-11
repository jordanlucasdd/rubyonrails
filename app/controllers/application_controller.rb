class ApplicationController < ActionController::Base

  before_action :authenticate_user


  def authenticate_user
    if session[:user_id]
      begin
        @current_user = UserPresenter.new(User.find(session[:user_id]))
      rescue ActiveRecord::RecordNotFound => e
        redirect_to login_path
      end
    else 
      redirect_to login_path
    end
  end

  def login_user user
    session[:user_id] = user.id
    Users::UseCases::UpdateUserData.new(user).execute
  end

  def check_if_is_admin
    unless @current_user.is_admin?
      flash[:notice] = "Você não tem permissão para acessar esta página."
      redirect_to root_path
    end
  end

end
