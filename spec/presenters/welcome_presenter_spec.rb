require 'rails_helper'
describe WelcomeFacade do # rubocop:disable Metrics/BlockLength
  it 'exists' do
    params = {}
    user = create(:user)
    wf = WelcomeFacade.new(params, user)

    expect(wf).to be_a(WelcomeFacade)
  end
  describe 'instance methods' do

    before :each do
      @params = {}
      @user = create(:user)
      @wf = WelcomeFacade.new(@params, @user)

      @tutorial1 = create(:tutorial)
      @tutorial2 = create(:tutorial, classroom: true)
    end

    it '#tutorials' do
      expected = Tutorial.all.pluck(:title)
      actual = @wf.tutorials.map(&:title)

      expect(actual).to eq(expected)
    end

    it '#users_tutorials' do
      expected = Tutorial.all.pluck(:title)
      actual = @wf.tutorials.map(&:title)

      expect(actual).to eq(expected)
    end

    it '#visitors_tutorials' do
      user = nil
      wf = WelcomeFacade.new(@params, user)
      expected = Tutorial.first.title
      actual = wf.tutorials.map(&:title)[0]

      expect(actual).to eq(expected)
    end
  end
end
