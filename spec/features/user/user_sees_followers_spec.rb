require 'rails_helper'

feature 'As a logged in user' do
  context 'when visiting /dashboard' do
    it 'sees all followers' do
      VCR.use_cassette('github_current_users_followers', :allow_playback_repeats => true) do
        VCR.use_cassette('github_current_users_repos', :allow_playback_repeats => true) do
          user = create(:user, token: ENV['PR_GITHUB_TOKEN'])
          login_as(user)

          expect(page).to have_content('Followers')
          expect(page).to have_css('.followers')

          facade = DashboardFacade.new(ENV['PR_GITHUB_TOKEN'])

          counter = 0
          facade.followers.each do |follower|
            expect(page).to have_css('.follower')

            within(page.all('.follower')[counter]) do
              expect(page).to have_css(".#{follower.handle}")
              expect(page).to have_link(follower.handle, href: follower.url)
            end
            counter += 1
          end
        end
      end
    end
  end
end
