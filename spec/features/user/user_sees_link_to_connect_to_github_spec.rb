require 'rails_helper'

feature 'as a user' do # rubocop:disable Metrics/BlockLength
  context 'when I visit my dashboard' do # rubocop:disable Metrics/BlockLength
    before :each do
      @user = create(:user)
      login_as(@user)
    end

    it 'sees a link to connect to GitHub' do
      expect(page).to have_link('Connect to GitHub')
    end

    it 'clicks link and is routed to GitHub' do
      VCR.use_cassette('github_other_users_repos',
                       allow_playback_repeats: true) do
        VCR.use_cassette('github_other_users_followers',
                         allow_playback_repeats: true) do
          VCR.use_cassette('github_other_users_followed',
                           allow_playback_repeats: true) do
            OmniAuth.config.test_mode = true
            OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
              provider: 'GitHub',
              uid: ENV['PR_GITHUB_UID'],
              credentials: {
                token: ENV['PR_GITHUB_TOKEN']
              }
            )

            click_link 'Connect to GitHub'
            user = User.last
            expect(user.id).to eq(@user.id)
            expect(user.token).to eq(ENV['PR_GITHUB_TOKEN'])
            expect(user.uid).to eq(ENV['PR_GITHUB_UID'].to_i)

            expect(page).to_not have_link('Connect to GitHub')
            expect(page).to have_content('GitHub')
          end
        end
      end
    end
  end
end
