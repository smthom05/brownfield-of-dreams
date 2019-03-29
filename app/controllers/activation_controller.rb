class ActivationController < ApplicationController
  def update
    if params[:id].to_i == current_user.id && !current_user.active?
      current_user.update_attribute(:active, true)
      flash[:notice] = 'Your account has been activated!'
      redirect_to dashboard_path
    else
      four_oh_four
    end
  end
end
