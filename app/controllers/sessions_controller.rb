class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    current_user ? create_token : find_and_route
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def create_token
    current_user.update_attribute(:token, request.env['omniauth.auth']['credentials']['token'])
    redirect_to dashboard_path
  end

  def find_and_route
    user = User.find_by(email: params[:session][:email])
    route_user(user)
  end

  def route_user(user)
    authn_user(user) ? set_current_user(user) : error_prompt
  end

  def authn_user(user)
    user && user.authenticate(params[:session][:password])
  end

  def set_current_user(user)
    session[:user_id] = user.id
    redirect_to dashboard_path
  end

  def error_prompt
    flash[:error] = "Looks like your email or password is invalid"
    render :new
  end

end
