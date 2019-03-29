require 'rails_helper'

feature 'As a newly registered user' do # rubocop:disable Metrics/BlockLength
  before :each do
    @email = 'jimbob@aol.com'
    @first_name = 'Jim'
    @last_name = 'Bob'
    @password = 'password'
    @password_confirmation = 'password'
    visit '/'
    click_on 'Sign In'
    click_on 'Sign up now.'
    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password
    click_on 'Create Account'
    @user = User.last
  end

  background do
    open_email(@email)
  end

  it 'an email is sent with a link to activate account' do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@user)
    expect(current_email.subject).to eq('Account Activation')
    expect(current_email)
      .to have_content("Welcome #{@user.first_name} #{@user.last_name}!")
    expect(current_email)
      .to have_link('Click here to activate your account.')

    current_email.click_link 'Click here to activate your account.'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Your account has been activated!')
    expect(page).to have_content('Status: Active')
  end
end
