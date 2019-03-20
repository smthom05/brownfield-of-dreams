require 'rails_helper'

feature 'As a logged in user' do
  context 'when visiting /dashboard' do
    it 'shows all followers for that user' do
      VCR.use_cassette('github_current_users_followers') do
        user = create(:user, token: ENV['github_other_token'])

        visit '/'

        click_on "Sign In"

        expect(current_path).to eq(login_path)

        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password

        click_on 'Log In'

        expect(page).to have_content("Followers")
        expect(page).to have_css('.followers')
        expect(page).to have_css('.follower', count: 7)
        within(page.all('.follower')[0]) do
          expect(page).to have_css('.follower-name')
          expect(page).to have_link('jojoxmz', href: "https://github.com/jojoxmz")
        end
      end
    end
  end
end
