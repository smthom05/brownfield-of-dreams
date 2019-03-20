require 'rails_helper'

describe 'Following' do
  it 'exists' do
    data = {login: "scootscoot", html_url: 'html.url'}
    following = Following.new(data)

    expect(following).to be_a(Following)
  end

  describe 'attributes' do
    it 'has a handle and a url' do
      data = {login: "scootscoot", html_url: 'html.url'}
      following = Following.new(data)

      expect(following.handle).to eq("scootscoot")
      expect(following.url).to eq("html.url")
    end
  end
end
