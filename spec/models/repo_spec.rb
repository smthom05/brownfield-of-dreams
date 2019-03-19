require 'rails_helper'

describe "Repo" do
  it 'exists' do
    data = {name: 'x', owner: {url: 'x'}}
    repo = Repo.new(data)

    expect(repo).to be_a(Repo)
  end

  describe 'attributes' do
    it 'has a name and url' do
      data = {name: 'name', owner: {url: 'url'}}
      repo = Repo.new(data)

      expect(repo.name).to eq('name')
      expect(repo.url).to eq('url')
    end
  end
end
