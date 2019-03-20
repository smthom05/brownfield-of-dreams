require 'rails_helper'

describe 'Follower' do
  it 'exists' do
    data = {login: "scootscoot", html_url: 'html.url'}
    follower = Follower.new(data)

    expect(follower).to be_a(Follower)
  end

  describe 'attributes' do
    it 'has a handle and a url' do
      data = {login: "scootscoot", html_url: 'html.url'}
      follower = Follower.new(data)

      expect(follower.handle).to eq("scootscoot")
      expect(follower.url).to eq("html.url")
    end
  end


end
