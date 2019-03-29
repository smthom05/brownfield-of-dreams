class InviteFacade

  def initialize(token)
    @token = token
  end

  def inviter
    service.find_user[:name]
  end

  def email(handle)
    response = service.get_id(handle)
    name = response[:name]
    email = response[:email]
    { name: name, email: email }
  end

  def service
    GithubService.new(@token)
  end

end
