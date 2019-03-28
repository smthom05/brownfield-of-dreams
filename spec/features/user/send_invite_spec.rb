require 'rails_helper'

feature 'as a registered user' do
  describe 'when I visit my dashboard' do

    before :each do
      @repo_response = File.open('./fixtures/pr_repos.json')
      @follower_response = File.open('./fixtures/pr_followers.json')
      @following_response = File.open('./fixtures/pr_following.json')
      @user_response = File.open('./fixtures/pr_user.json')
      @users_by_name_response = File.open('./fixtures/users_st.json')
      @no_name_response = File.open('./fixtures/users_no.json')
      stub_request(:get, 'https://api.github.com/user/repos').to_return(status: 200, body: @repo_response)
      stub_request(:get, 'https://api.github.com/user/followers').to_return(status: 200, body: @follower_response)
      stub_request(:get, 'https://api.github.com/user/following').to_return(status: 200, body: @following_response)
      stub_request(:get, 'https://api.github.com/user').to_return(status: 200, body: @user_response)
      stub_request(:get, 'https://api.github.com/users/smthom05').to_return(status: 200, body: @users_by_name_response)
      stub_request(:get, 'https://api.github.com/users/otorrinolaringologo').to_return(status: 200, body: @no_name_response)

      @user = create(:user, token: ENV['PR_GITHUB_TOKEN'])
      login_as(@user)
    end

    it 'can send an invite' do
      expect(page).to have_link('Send an Invite')

      click_link('Send an Invite')

      expect(current_path).to eq(invite_path)

      expect(page).to have_content('Github handle')
      expect(page).to have_button('Send Invite')

      fill_in 'github_handle', with: 'smthom05'

      click_button 'Send Invite'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Successfully sent invite!')

      click_link('Send an Invite')

      fill_in 'github_handle', with: 'otorrinolaringologo'

      click_button('Send Invite')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('The Github user you selected doesn\'t have an email address associated with their account.')
    end
  end
end
