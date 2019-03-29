require 'rails_helper'

describe 'User' do
  before :each do
    @user = create(:user)
  end

  it 'user can sign in' do
    visit '/'
    login_as(@user)

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(
      "Logged in as #{@user.first_name} #{@user.last_name}"
    )
    expect(page).to have_content(@user.email)
    expect(page).to have_content(@user.first_name)
    expect(page).to have_content(@user.last_name)
  end

  it 'can log out', :js do
    login_as(@user)

    click_on 'Profile'

    expect(current_path).to eq(dashboard_path)

    click_on 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to_not have_content(@user.first_name)
    expect(page).to have_content('SIGN IN')
  end

  it 'is shown an error when incorrect info is entered' do
    fake_email = 'email@email.com'
    fake_password = '123'

    visit login_path

    fill_in'session[email]', with: fake_email
    fill_in'session[password]', with: fake_password

    click_on 'Log In'

    expect(page).to have_content('Looks like your email or password is invalid')
  end
end
