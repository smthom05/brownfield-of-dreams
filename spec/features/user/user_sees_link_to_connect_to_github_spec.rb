require 'rails_helper'

feature 'as a user' do
  context 'when I visit my dashboard' do

    before :each do
      @user = create(:user)
      login_as(@user)
    end

    it 'sees a link to connect to GitHub' do
      expect(page).to have_link('Connect to GitHub')
    end

    it 'clicks link and is routed to GitHub' do
      VCR.use_cassette('github_other_users_repos', :allow_playback_repeats => true) do
        VCR.use_cassette('github_other_users_followers', :allow_playback_repeats => true) do
          VCR.use_cassette('github_other_users_followed', :allow_playback_repeats => true) do
            OmniAuth.config.test_mode = true
            OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
              provider: 'GitHub',
              credentials: {
                token: ENV['github_user_token']
              }
              })

            click_link 'Connect to GitHub'
            user = User.last
            expect(user.id).to eq(@user.id)
            expect(user.token).to eq(ENV['github_user_token'])

            expect(page).to_not have_link('Connect to GitHub')
            expect(page).to have_content('GitHub')
          end
        end
      end
    end
  end
end
