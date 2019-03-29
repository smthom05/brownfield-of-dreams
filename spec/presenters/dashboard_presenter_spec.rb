require 'rails_helper'
describe DashboardFacade do # rubocop:disable Metrics/BlockLength
  it 'exists' do
    token = 'token'
    df = DashboardFacade.new(token)

    expect(df).to be_a(DashboardFacade)
  end
  describe 'instance methods' do # rubocop:disable Metrics/BlockLength
    describe '#repos' do
      it 'returns five repos' do
        VCR.use_cassette('github_current_users_repos') do
          token = ENV['PR_GITHUB_TOKEN']
          df = DashboardFacade.new(token)

          df.repos
        end
      end
    end

    describe '#followers' do
      it 'returns all followers' do
        VCR.use_cassette('github_current_users_followers') do
          token = ENV['PR_GITHUB_TOKEN']
          df = DashboardFacade.new(token)

          df.followers
        end
      end
    end

    describe '#followed' do
      it 'returns all followed users' do
        VCR.use_cassette('github_current_users_followed') do
          token = ENV['PR_GITHUB_TOKEN']
          df = DashboardFacade.new(token)

          df.followed
        end
      end
    end

    describe '#friends' do
      it 'returns all friends users' do
        user1 = create(:user, uid: 1)
        user2 = create(:user, uid: 2)

        Friend.create(user_id: user1.id, friend_id: user2.id)

        token = ENV['PR_GITHUB_TOKEN']
        df = DashboardFacade.new(token)

        expect(df.friends(user1)).to eq([user2])
      end
    end

    describe '#bookmarks(current_user)' do
      it 'returns a hash of bookmarked videos keyed by tutorial' do
        user = create(:user)
        tutorial = create(:tutorial)
        video = create(:video, tutorial_id: tutorial.id)
        uservideo = create(:user_video, user_id: user.id, video_id: video.id)
        token = ENV['PR_GITHUB_TOKEN']
        df = DashboardFacade.new(token)

        expect(df.bookmarks(user).keys).to eq([tutorial.title])
      end
    end
  end
end
