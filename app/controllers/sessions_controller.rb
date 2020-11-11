class SessionsController < ApplicationController  

  skip_before_action :authenticate_user, only: [:google_auth, :new]

  def google_auth

    begin
      access_token = request.env["omniauth.auth"]
      user = Auth::UseCases::AuthenticateWithGoogle.new.execute(access_token)
      login_user(user)
      redirect_to root_path
    rescue AuthenticationFailed => e
      flash[:warning] = e.message
      redirect_to login_path
    rescue Exception => e
      flash[:warning] = "Ops.. erro ao logar - (#{e.message})"
      redirect_to login_path
    end
    
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  def new
    render layout: nil
  end


end
