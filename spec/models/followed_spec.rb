require 'rails_helper'

describe 'Followed' do
  it 'exists' do
    data = {login: 'followed_user', html_url: 'github.com/followed_user'}
    followed = Followed.new(data)

    expect(followed).to be_a(Followed)
  end

  describe 'attributes' do
    it 'has a handle, url and uid' do
      data = {login: 'followed_user', html_url: 'github.com/followed_user', id: '4'}
      followed = Followed.new(data)

      expect(followed.handle).to eq('followed_user')
      expect(followed.url).to eq('github.com/followed_user')
      expect(followed.uid).to eq(4)
    end
  end

  describe 'instance methods' do
    it 'exists?' do
      create(:user, uid: 4)
      data = {login: 'followed_user', html_url: 'github.com/followed_user', id: '4'}
      followed = Followed.new(data)

      expect(followed.exists?).to eq(true)

      data = {login: 'followed_user', html_url: 'github.com/followed_user', id: '5'}
      followed = Followed.new(data)

      expect(followed.exists?).to eq(false)
    end
  end
end
