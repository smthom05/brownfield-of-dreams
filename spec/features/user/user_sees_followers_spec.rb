require 'rails_helper'

feature 'As a logged in user' do # rubocop:disable Metrics/BlockLength
  context 'when visiting /dashboard' do # rubocop:disable Metrics/BlockLength
    before :each do
      @repo_response = File.open('./fixtures/pr_repos.json')
      @follower_response = File.open('./fixtures/pr_followers.json')
      @following_response = File.open('./fixtures/pr_following.json')
      stub_request(:get, 'https://api.github.com/user/repos')
        .to_return(status: 200, body: @repo_response)
      stub_request(:get, 'https://api.github.com/user/followers')
        .to_return(status: 200, body: @follower_response)
      stub_request(:get, 'https://api.github.com/user/following')
        .to_return(status: 200, body: @following_response)
    end

    it 'sees all followers' do
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
