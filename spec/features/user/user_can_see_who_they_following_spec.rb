require 'rails_helper'

feature 'As a logged in user' do
  context 'when visiting /dashboard' do
    it 'sees all of the users they are following' do
      VCR.use_cassette('github_current_users_following') do
        user = create(:user, token: ENV['github_user_token'])

        visit '/'

        click_on "Sign In"

        expect(current_path).to eq(login_path)

        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password

        click_on 'Log In'

        expect(page).to have_content('Following')
        expect(page).to have_css('.following')
        expect(page).to have_css('.followed-user', count: 4)
        within(page.all('.followed-user')[0]) do
          expect(page).to have_css('.following-name')
          expect(page).to have_link('bolensmichael', href: 'https://github.com/michaelbolens')
        end
      end
    end
  end
end
