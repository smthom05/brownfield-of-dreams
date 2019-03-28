require 'rails_helper'

feature 'As a logged in user' do
  context 'when visiting /dashboard' do

    before :each do
      @repo_response = File.open('./fixtures/pr_repos.json')
      @follower_response = File.open('./fixtures/pr_followers.json')
      @following_response = File.open('./fixtures/pr_following.json')
      stub_request(:get, 'https://api.github.com/user/repos').to_return(status: 200, body: @repo_response)
      stub_request(:get, 'https://api.github.com/user/followers').to_return(status: 200, body: @follower_response)
      stub_request(:get, 'https://api.github.com/user/following').to_return(status: 200, body: @following_response)
    end

    it 'sees a link to add friend if follower/following has an account' do
      user = create(:user, token: ENV['PR_GITHUB_TOKEN'])
      user_2 = create(:user, token: ENV['ST_GITHUB_TOKEN'], uid: ENV['ST_GITHUB_UID'])
      login_as(user)

      expect(page).to have_link('Add Friend', count: 2)
      expect(page).to_not have_content('Friends')
    end

    it 'sees a Friends section that shows the users friends' do
      user = create(:user, token: ENV['PR_GITHUB_TOKEN'])
      user_2 = create(:user, first_name: 'Scott', last_name: 'Thomas', token: ENV['ST_GITHUB_TOKEN'], uid: ENV['ST_GITHUB_UID'])
      login_as(user)

      within '.followed' do
        click_link 'Add Friend'
      end

      expect(page).to have_content("Friends")
      expect(page).to have_css('.friends')
      within '.friends' do
        expect(page).to have_content('Scott Thomas')
      end

      expect(page).to_not have_link('Add Friend')
    end

    it 'prompts if friendship is invalid' do
      allow_any_instance_of(Friend).to receive(:save).and_return(false)

      user = create(:user, token: ENV['PR_GITHUB_TOKEN'])
      user_2 = create(:user, first_name: 'Scott', last_name: 'Thomas', token: ENV['ST_GITHUB_TOKEN'], uid: ENV['ST_GITHUB_UID'])
      login_as(user)

      within '.followed' do
        click_link 'Add Friend'
      end

      expect(page).to_not have_css('.friends')
      expect(page).to have_link('Add Friend')
      expect(page).to have_content("Invalid Friendship")
    end
  end
end
