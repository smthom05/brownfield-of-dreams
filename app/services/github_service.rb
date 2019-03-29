class GithubService

  def initialize(token)
    @token = token
  end

  def find_user
    get_json('/user')
  end

  def get_id(handle)
    get_json("/users/#{handle}")
  end

  def find_repos
    get_json('/user/repos')
  end

  def find_followers
    get_json('/user/followers')
  end

  def find_followed
    get_json('/user/following')
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{@token}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
