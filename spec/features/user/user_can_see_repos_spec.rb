require 'rails_helper'

feature 'As a logged in user' do # rubocop:disable Metrics/BlockLength
  context 'when visiting /dashboard' do # rubocop:disable Metrics/BlockLength
    it 'sees a GitHub section only if it has a token' do
      user = create(:user, token: nil)

      login_as(user)

      expect(page).to_not have_content('Repositories')
    end

    it 'sees a list of five repos' do # rubocop:disable Metrics/BlockLength
      repo_response = File.open('./fixtures/pr_repos.json')
      follower_response = File.open('./fixtures/pr_followers.json')
      following_response = File.open('./fixtures/pr_following.json')
      stub_request(:get, 'https://api.github.com/user/repos')
        .to_return(status: 200, body: repo_response)
      stub_request(:get, 'https://api.github.com/user/followers')
        .to_return(status: 200, body: follower_response)
      stub_request(:get, 'https://api.github.com/user/following')
        .to_return(status: 200, body: following_response)

      user = create(:user, token: ENV['PR_GITHUB_TOKEN'])
      login_as(user)

      expect(page).to have_content('GitHub')
      expect(page).to have_css('.github')

      expect(page).to have_css('.repo', count: 5)
      within(page.all('.repo')[0]) do
        expect(page).to have_css('.repo-name')
        expect(page)
          .to have_link('little_shop',
                        href: 'https://github.com/aprildagonese/little_shop')
      end
      within(page.all('.repo')[1]) do
        expect(page).to have_css('.repo-name')
        expect(page)
          .to have_link('book_club',
                        href: 'https://github.com/n-flint/book_club')
      end
      within(page.all('.repo')[2]) do
        expect(page).to have_css('.repo-name')
        expect(page)
          .to have_link('activerecord-obstacle-course',
                        href: 'https://github.com/PeregrineReed/' \
                              'activerecord-obstacle-course')
      end
      within(page.all('.repo')[3]) do
        expect(page).to have_css('.repo-name')
        expect(page)
          .to have_link('activerecord_exploration',
                        href: 'https://github.com/PeregrineReed' \
                              '/activerecord_exploration')
      end
      within(page.all('.repo')[4]) do
        expect(page).to have_css('.repo-name')
        expect(page)
          .to have_link('apollo_14',
                        href: 'https://github.com/PeregrineReed/apollo_14')
      end
    end

    it 'sees only five repos of current user' do # rubocop:disable Metrics/BlockLength, Metrics/LineLength
      VCR.use_cassette('github_other_users_repos', # rubocop:disable Metrics/BlockLength, Metrics/LineLength
                       allow_playback_repeats: true) do
        VCR.use_cassette('github_other_users_followers', # rubocop:disable Metrics/BlockLength, Metrics/LineLength
                         allow_playback_repeats: true) do
          VCR.use_cassette('github_other_users_followed', # rubocop:disable Metrics/BlockLength, Metrics/LineLength
                           allow_playback_repeats: true) do

            user2 = create(:user, token: ENV['ST_GITHUB_TOKEN'])

            login_as(user2)

            within(page.all('.repo')[0]) do
              expect(page)
                .to have_link('little_shop',
                              href: 'https://github.com/' \
                                    'aprildagonese/little_shop')
            end
            within(page.all('.repo')[1]) do
              expect(page)
                .to_not have_link('book_club',
                                  href: 'https://github.com/n-flint/book_club')
            end
            within(page.all('.repo')[2]) do
              expect(page)
                .to_not have_link('activerecord-obstacle-course',
                                  href: 'https://github.com/PeregrineReed/' \
                                        'activerecord-obstacle-course')
            end
            within(page.all('.repo')[3]) do
              expect(page)
                .to_not have_link('activerecord_exploration',
                                  href: 'https://github.com/PeregrineReed/' \
                                        'activerecord_exploration')
            end
            within(page.all('.repo')[4]) do
              expect(page)
                .to_not have_link('apollo_14',
                                  href: 'https://github.com/' \
                                        'PeregrineReed/apollo_14')
            end
          end
        end
      end
    end
  end
end
