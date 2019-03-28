# require 'rails_helper'
#
# describe 'InviteMailer', type: :mailer do
#
#   before :each do
#     @name = 'Peregrine Reed Balas'
#     @email = 'peregrinereedbalas@gmail.com'
#     @invitee = { name: @name, email: @email }
#     @inviter = 'Scott Thomas'
#   end
#
#   background do
#     open_email(@email)
#   end
#
#   it 'sends an invite to register' do
#     InviteMailer.invite(@inviter, @invitee).deliver_now
#
#     expect(current_email.subject).to eq('An Invite to Your Dreams!')
#     expect(current_email).to have_content("Hello #{ @name },")
#     expect(current_email).to have_content("#{ @inviter } has invited you to join Brownfield Of Dreams. You can create an account here.")
#     expect(current_email).to have_link('here', href: register_url)
#
#     current_email.click_link 'here'
#     expect(current_path).to eq(register_path)
#   end
#
# end
