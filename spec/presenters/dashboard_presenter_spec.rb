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
          token = ENV["github_user_token"]
          df = DashboardFacade.new(token)

          df.repos
        end
      end
    end

    describe '#follwers' do
      it 'returns followers' do
        VCR.use_cassette('github_current_users_followers') do
          token = ENV["github_user_token"]
          df = DashboardFacade.new(token)

          df.followers
        end
      end
    end

    describe '#follwing' do
      it 'returns users they are following' do
        VCR.use_cassette('github_current_users_following') do
          token = ENV["github_user_token"]
          df = DashboardFacade.new(token)

          df.following
        end
      end
    end
  end
end
