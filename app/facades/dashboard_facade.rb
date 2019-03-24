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

  def followers
    response = service.get_followers
    response.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def followed
    response = service.get_followed
    response.map do |followed_data|
      Followed.new(followed_data)
    end
  end

  def friends(current_user)
    User.joins('JOIN friends ON users.id = friends.friend_id')
        .where(friends: {user_id: current_user.id})
  end

  def service
    GithubService.new(@user_token)
  end

end
