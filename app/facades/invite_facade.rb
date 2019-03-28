class InviteFacade

  def initialize(token)
    @token = token
  end

  def inviter
    service.get_user[:name]
  end

  def email(handle)
    response = service.get_id(handle)
    id = response[:id]
    name = response[:name]
    email = "#{id}+#{handle}@users.noreply.github.com"
    { name: name, email: email }
  end

  def service
    GithubService.new(@token)
  end

end
