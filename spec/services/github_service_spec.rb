require 'rails_helper'

describe GithubService do # rubocop:disable Metrics/BlockLength
  it 'exists' do
    token = {}
    service = GithubService.new(token)

    expect(service).to be_a(GithubService)
  end

  describe 'instance methods' do # rubocop:disable Metrics/BlockLength
    describe '#find_repos' do
      it 'returns a hash of github repository data' do
        VCR.use_cassette('github_current_users_repos') do
          token = ENV['PR_GITHUB_TOKEN']
          service = GithubService.new(token)

          result = service.find_repos

          expect(result).to be_a(Array)
          expect(result[0]).to have_key(:id)
        end
      end
    end

    describe '#find_followers' do
      it 'returns a hash of github followers data' do
        VCR.use_cassette('github_current_users_followers') do
          token = ENV['PR_GITHUB_TOKEN']
          service = GithubService.new(token)

          result = service.find_followers

          expect(result).to be_a(Array)
          expect(result[0]).to have_key(:id)
        end
      end
    end

    describe '#find_followed' do
      it 'returns a hash of github followed user data' do
        VCR.use_cassette('github_current_users_followed') do
          token = ENV['PR_GITHUB_TOKEN']
          service = GithubService.new(token)

          result = service.find_followed

          expect(result).to be_a(Array)
          expect(result[0]).to have_key(:id)
        end
      end
    end
  end
end
