class Follower
  attr_reader :handle,
              :url,
              :uid

  def initialize(data)
    @handle = data[:login]
    @url = data[:html_url]
    @uid = data[:id].to_i
  end

  def exists?
    User.find_by(uid: @uid).class == User
  end
end
