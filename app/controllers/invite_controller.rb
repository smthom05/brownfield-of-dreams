class InviteController < ApplicationController
  def new; end

  def create
    facade = InviteFacade.new(current_user.token)
    inviter = facade.inviter
    invitee = facade.email(params[:github_handle])
    to_mail_or_not_to_mail(inviter, invitee)
    redirect_to dashboard_path
  end

  def to_mail_or_not_to_mail(inviter, invitee)
    if invitee[:email]
      InviteMailer.invite(inviter, invitee).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = 'The Github user you selected' \
                      ' doesn\'t have an email address' \
                      ' associated with their account.'
    end
  end
end
