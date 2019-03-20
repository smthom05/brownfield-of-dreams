require 'rails_helper'

feature 'As a logged in user' do
  context 'when visiting /dashboard' do

    it 'sees a GitHub section only if it has a token' do
      user = create(:user, token: nil)

      visit '/'

      click_on "Sign In"

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(page).to_not have_content("GitHub")
    end

    it 'sees a list of five repos' do
      VCR.use_cassette('github_current_users_repos') do
        user = create(:user, token: 'token')

        visit '/'

        click_on "Sign In"

        expect(current_path).to eq(login_path)

        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password

        click_on 'Log In'

        expect(page).to have_content("GitHub")
        expect(page).to have_css(".github")
        expect(page).to have_css(".repo", count: 5)
        within(page.all(".repo")[0]) do
          expect(page).to have_css(".repo-name")
          expect(page).to have_link("little_shop", href: "https://github.com/aprildagonese/little_shop")
        end
        within(page.all(".repo")[1]) do
          expect(page).to have_css(".repo-name")
          expect(page).to have_link("book_club", href: "https://github.com/n-flint/book_club")
        end
        within(page.all(".repo")[2]) do
          expect(page).to have_css(".repo-name")
          expect(page).to have_link("activerecord-obstacle-course", href: "https://github.com/PeregrineReed/activerecord-obstacle-course")
        end
        within(page.all(".repo")[3]) do
          expect(page).to have_css(".repo-name")
          expect(page).to have_link("activerecord_exploration", href: "https://github.com/PeregrineReed/activerecord_exploration")
        end
        within(page.all(".repo")[4]) do
          expect(page).to have_css(".repo-name")
          expect(page).to have_link("apollo_14", href: "https://github.com/PeregrineReed/apollo_14")
        end
      end
    end

    xit 'sees only five repos of current user' do
      user = create(:user, token: 'token')
      user_2 = create(:user, token: 'other')

      user_response = File.open("./fixtures/user_github_mock_repos.json")
      stub_request(:get, "https://api.github.com/user/repos").with(headers: {Authorization: "token #{user.token}"}).to_return(status: 200, body: user_response)
      user = create(:user)

      other_response = File.open("./fixtures/other_github_mock_repos.json")
      stub_request(:get, "https://api.github.com/user/repos").with(headers: {Authorization: "token #{user_2.token}"}).to_return(status: 200, body: other_response)

      visit '/'

      click_on "Sign In"

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'
      counter = 0
      5.times do
        within(page.all(".repo")[counter]) do
          expect(page).to have_link("activerecord_exploration", href: "https://github.com/PeregrineReed/activerecord_exploration")
        end
        counter += 1
      end
    end
  end
end
