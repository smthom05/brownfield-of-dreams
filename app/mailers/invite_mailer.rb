class InviteMailer < ApplicationMailer
  def invite(inviter, invitee)
    @email = invitee[:email]
    @name = invitee[:name]
    @inviter = inviter

    mail(to: @email, subject: "An Invite to Your Dreams!")

  end
end
