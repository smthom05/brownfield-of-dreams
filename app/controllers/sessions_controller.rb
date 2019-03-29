class SessionsController < ApplicationController
  def new
    @new ||= User.new
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
    oauth_hash = request.env['omniauth.auth']
    current_user.update_attribute(:token, oauth_hash['credentials']['token'])
    current_user.update_attribute(:uid, oauth_hash['uid'])
    redirect_to dashboard_path
  end

  def find_and_route
    user = User.find_by(email: params[:session][:email])
    route_user(user)
  end

  def route_user(user)
    authn_user(user) ? create_current_user(user) : error_prompt
  end

  def authn_user(user)
    user&.authenticate(params[:session][:password])
  end

  def create_current_user(user)
    session[:user_id] = user.id
    flash[:notice] = "Logged in as #{user.first_name} #{user.last_name}"
    redirect_to dashboard_path
  end

  def error_prompt
    flash[:error] = 'Looks like your email or password is invalid'
    render :new
  end

end
