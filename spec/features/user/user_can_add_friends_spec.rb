require 'rails_helper'

feature 'As a logged in user' do
  context 'when visiting /dashboard' do
    it 'sees a link to add friend if follower has an account' do
      VCR.use_cassette('github_current_users_followers', :allow_playback_repeats => true) do
        VCR.use_cassette('github_current_users_repos', :allow_playback_repeats => true) do
          user = create(:user, token: ENV['PR_GITHUB_TOKEN'])
          user_2 = create(:user, token: ENV['ST_GITHUB_TOKEN'])
          login_as(user)

          within ".followers" do
            expect(page).to have_link("Add Friend")
          end

        end
      end
    end
  end
end
