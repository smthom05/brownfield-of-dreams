class DashboardRepoFacade

  def initialize(user_token)
    @user_token = user_token
  end

  def repos
    response = service.get_repos
    response.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def service
    GithubService.new(@user_token)
  end

end
