class DashboardFacade

  def initialize(user_token)
    @user_token = user_token
  end

  def repos
    response = service.get_repos
    response.map do |repo_data|
      Repo.new(repo_data)
    end[0..4]
  end

  def service
    GithubService.new(@user_token)
  end

  def followers
    response = service.get_followers
    response.map do |follower_data|
      Follower.new(follower_data)
    end
  end

end
