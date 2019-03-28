require 'rails_helper'

feature 'as a registered user' do
  describe 'when I visit my dashboard' do

    before :each do
      @repo_response = File.open('./fixtures/pr_repos.json')
      @follower_response = File.open('./fixtures/pr_followers.json')
      @following_response = File.open('./fixtures/pr_following.json')
      @user_response = File.open('./fixtures/pr_user.json')
      @users_by_name_response = File.open('./fixtures/users_pr.json')
      @no_name_response = File.open('./fixtures/users_no.json')
      stub_request(:get, 'https://api.github.com/user/repos').to_return(status: 200, body: @repo_response)
      stub_request(:get, 'https://api.github.com/user/followers').to_return(status: 200, body: @follower_response)
      stub_request(:get, 'https://api.github.com/user/following').to_return(status: 200, body: @following_response)
      stub_request(:get, 'https://api.github.com/user').to_return(status: 200, body: @user_response)
      stub_request(:get, 'https://api.github.com/users/PeregrineReed').to_return(status: 200, body: @users_by_name_response)
      stub_request(:get, 'https://api.github.com/users/otorrinolaringologo').to_return(status: 200, body: @no_name_response)

      @user = create(:user, token: ENV['PR_GITHUB_TOKEN'])
    end

    it 'can send an invite' do
      login_as(@user)
      expect(page).to have_link('Send an Invite')

      click_link('Send an Invite')

      expect(current_path).to eq(invite_path)

      expect(page).to have_content('Github handle')
      expect(page).to have_button('Send Invite')

      fill_in 'github_handle', with: 'PeregrineReed'

      click_button 'Send Invite'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Successfully sent invite!')

      click_link('Send an Invite')

      fill_in 'github_handle', with: 'otorrinolaringologo'

      click_button('Send Invite')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('The Github user you selected doesn\'t have an email address associated with their account.')
    end

    context 'recipient' do
      before :each do
        @name = 'Peregrine Reed Balas'
        @email = 'peregrinereedbalas@gmail.com'
        @invitee = { name: @name, email: @email }
        @inviter = 'Scott Thomas'
        @scott = create(:user, token: ENV['ST_GITHUB_TOKEN'])
      end

      background do
        open_email(@email)
      end

      it 'sends an invite to register' do
        login_as(@scott)
        click_link('Send an Invite')
        fill_in 'github_handle', with: 'PeregrineReed'
        click_button 'Send Invite'

        expect(current_email.subject).to eq('An Invite to Your Dreams!')
        expect(current_email).to have_content("Hello #{ @name },")
        expect(current_email).to have_content("#{ @inviter } has invited you to join Brownfield Of Dreams. You can create an account here.")
        expect(current_email).to have_link('here', href: register_url)

        current_email.click_link 'here'
        expect(current_path).to eq(register_path)
      end
    end
  end
end
