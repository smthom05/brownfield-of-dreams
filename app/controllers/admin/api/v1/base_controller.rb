class Admin::Api::V1::BaseController < ActionController::API
  before_action :require_admin!

  def require_admin!
    four_oh_four unless current_user.admin?
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user ||= User.new
    end
  end
end
