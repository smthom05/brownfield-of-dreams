require 'rails_helper'

describe "Follower" do
  it 'exists' do
    data = {login: 'x', html_url: 'x'}
    follower = Follower.new(data)

    expect(follower).to be_a(Follower)
  end

  describe 'attributes' do
    it 'has a handle and url' do
      data = {login: 'name', html_url: 'url'}
      follower = Follower.new(data)

      expect(follower.handle).to eq('name')
      expect(follower.url).to eq('url')
    end
  end
end
