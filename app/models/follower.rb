class Follower

  attr_reader :handle,
              :url

  def initialize(data)
    @handle = data[:login]
    @url = data[:html_url]
  end

end
