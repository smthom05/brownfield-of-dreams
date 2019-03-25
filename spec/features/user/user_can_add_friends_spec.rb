require 'rails_helper'

feature 'As a logged in user' do
  context 'when visiting /dashboard' do
    it 'sees a link to add friend if follower/following has an account' do
      VCR.use_cassette('github_current_users_followers', allow_playback_repeats: true) do
        VCR.use_cassette('github_current_users_repos', allow_playback_repeats: true) do
          user = create(:user, token: ENV['PR_GITHUB_TOKEN'])
          user_2 = create(:user, token: ENV['ST_GITHUB_TOKEN'], uid: ENV['ST_GITHUB_UID'])
          login_as(user)

          expect(page).to have_link('Add Friend', count: 2)
        end
      end
    end

    it 'sees a Friends section that shows the users friends' do
      VCR.use_cassette('github_current_users_followers', allow_playback_repeats: true) do
        VCR.use_cassette('github_current_users_repos', allow_playback_repeats: true) do
          user = create(:user, token: ENV['PR_GITHUB_TOKEN'])
          user_2 = create(:user, first_name: 'Scott', last_name: 'Thomas', token: ENV['ST_GITHUB_TOKEN'], uid: ENV['ST_GITHUB_UID'])
          login_as(user)

          expect(page).to have_content('Friends')
          within '.friends' do
            expect(page).to_not have_content('smthom05')
          end

          within '.followed' do
            click_link 'Add Friend'
          end

          within '.friends' do
            expect(page).to have_content('Scott Thomas')
          end

          expect(page).to_not have_link('Add Friend')
        end
      end
    end
  end
end
