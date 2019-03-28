class InviteController < ApplicationController

  def new
  end

  def create
    facade = InviteFacade.new(current_user.token)
    inviter = facade.inviter
    invitee = facade.email(params[:github_handle])
    unless invitee[:email] == nil
      InviteMailer.invite(inviter, invitee).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = 'The Github user you selected doesn\'t have an email address associated with their account.'
    end
    redirect_to dashboard_path
  end

end
