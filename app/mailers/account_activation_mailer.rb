class AccountActivationMailer < ApplicationMailer
  def activate(user)
    @user = user

    mail(to: @user.email, subject: "Account Activation")

  end
end
