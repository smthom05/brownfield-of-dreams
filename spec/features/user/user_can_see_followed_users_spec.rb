require 'rails_helper'

feature 'As a logged in user' do # rubocop:disable Metrics/BlockLength
  context 'when visiting /dashboard' do
    it 'sees all followed users' do
      VCR.use_cassette('github_current_users_repos',
                       allow_playback_repeats: true) do
        VCR.use_cassette('github_current_users_followers',
                         allow_playback_repeats: true) do
          VCR.use_cassette('github_current_users_followed',
                           allow_playback_repeats: true) do
            user = create(:user, token: ENV['PR_GITHUB_TOKEN'])
            login_as(user)

            expect(page).to have_content('Followed')
            expect(page).to have_css('.followed')

            facade = DashboardFacade.new(ENV['PR_GITHUB_TOKEN'])

            counter = 0

            facade.followed.each do |f|
              expect(page).to have_css('.followed-user')

              within(page.all('.followed-user')[counter]) do
                expect(page).to have_css(".#{f.handle}")
                expect(page).to have_link(f.handle, href: f.url)
              end
              counter += 1
            end
          end
        end
      end
    end
  end
end
