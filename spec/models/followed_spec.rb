require 'rails_helper'

describe "Followed" do
  it 'exists' do
    data = {login: 'followed_user', html_url: 'github.com/followed_user'}
    followed = Followed.new(data)

    expect(followed).to be_a(Followed)
  end

  describe 'attributes' do
    it 'has a handle and url' do
      data = {login: 'followed_user', html_url: 'github.com/followed_user'}
      followed = Followed.new(data)

      expect(followed.handle).to eq('followed_user')
      expect(followed.url).to eq('github.com/followed_user')
    end
  end
end
