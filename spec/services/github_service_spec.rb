require 'rails_helper'

describe GithubService do

  it 'exists' do
    token = {}
    service = GithubService.new(token)

    expect(service).to be_a(GithubService)
  end

  describe 'instance methods' do
    describe '#get_repos' do
      it 'returns an array of github repository data' do
        VCR.use_cassette("github_current_users_repos") do
          token = ENV["github_user_token"]
          service = GithubService.new(token)

          result = service.get_repos

          expect(result).to be_a(Array)
          expect(result[0]).to have_key(:id)
        end
      end
    end

    describe '#get_followers' do
      it 'returns an array of github follower data' do
        VCR.use_cassette('github_current_users_followers') do
          token = ENV['github_user_token']
          service = GithubService.new(token)

          result = service.get_followers

          expect(result).to be_a(Array)
          expect(result[0]).to have_key(:id)
        end
      end
    end

    describe '#get_following' do
      it 'returns an array of github following data' do
        VCR.use_cassette('github_current_users_following') do
          token = ENV['github_user_token']
          service = GithubService.new(token)

          result = service.get_following

          expect(result).to be_a(Array)
          expect(result[0]).to have_key(:id)
        end
      end
    end
  end

end
