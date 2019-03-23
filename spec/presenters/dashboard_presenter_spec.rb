require 'rails_helper'
describe DashboardFacade do
  it 'exists' do
    token = "token"
    df = DashboardFacade.new(token)

    expect(df).to be_a(DashboardFacade)
  end
  describe 'instance methods' do

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

  end
end
