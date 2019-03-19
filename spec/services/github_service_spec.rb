require 'rails_helper'

describe GithubService do

  it 'exists' do
    token = {}
    service = GithubService.new(token)

    expect(service).to be_a(GithubService)
  end

  describe 'instance methods' do
    describe '#get_repos' do
      it 'returns a hash of github repository data' do
        VCR.use_cassette("github_current_users_repos") do
          token = ENV["github_user_token"]
          service = GithubService.new(token)

          result = service.get_repos

          expect(result).to be_a(Array)
          expect(result[0]).to have_key(:id)
        end
      end
    end
  end

end
