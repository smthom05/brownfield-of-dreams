require 'rails_helper'

describe 'InviteFacade' do

  before :each do
    @handle = 'PeregrineReed'
    @token = ENV['PR_GITHUB_TOKEN']
  end

  it 'exists' do
    inv = InviteFacade.new(@token)

    expect(inv).to be_a(InviteFacade)
  end

  it '#email' do
    VCR.use_cassette('github_user_email') do
      inv = InviteFacade.new(@token)

      expected = {
        name: 'Peregrine Reed Balas',
        email: 'peregrinereedbalas@gmail.com'
      }

      expect(inv.email(@handle)).to eq(expected)
    end
  end
end
