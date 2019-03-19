class Repo

  attr_reader :name,
              :url

  def initialize(data)
    @name = data[:name]
    @url = data[:owner][:url]
  end

end
