require 'rails_helper'

describe 'Follower' do
  it 'exists' do
    data = {login: 'x', html_url: 'x'}
    follower = Follower.new(data)

    expect(follower).to be_a(Follower)
  end

  describe 'attributes' do
    it 'has a handle, url and uid' do
      data = {login: 'name', html_url: 'url', id: '3'}
      follower = Follower.new(data)

      expect(follower.handle).to eq('name')
      expect(follower.url).to eq('url')
      expect(follower.uid).to eq(3)
    end
  end

  describe 'instance methods' do
    it 'exists?' do
      create(:user, uid: 4)
      data = {login: 'follower', html_url: 'github.com/follower', id: '4'}
      followed = Follower.new(data)

      expect(followed.exists?).to eq(true)

      data = {login: 'follower', html_url: 'github.com/follower', id: '5'}
      followed = Follower.new(data)

      expect(followed.exists?).to eq(false)
    end
  end
end
