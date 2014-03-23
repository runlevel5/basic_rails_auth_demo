class SessionsController < ApplicationController
  skip_before_filter :authenticate!

  def new
  end

  def create
    if user = UserAuthentication.authenticate(session_params)
      session[:user_id] = user.id

      flash[:success] = 'You are now signed in'
      redirect_to_referrer
    else
      flash[:error] = 'There was a problem logging you in'
      redirect_to login_url
    end
  end

  def destroy
    session[:user_id] = nil

    flash[:success] = 'You are now signed out'
    redirect_to login_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password).symbolize_keys
  end

  def redirect_to_referrer
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_url
  end

end