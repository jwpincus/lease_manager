RSpec.feature 'With valid user:', type: :feature do
  before :each do
    @user = create(:user)
  end
  it "can log in" do
    visit '/login'
    fill_in('email', with: @user.email)
    fill_in('password', with: @user.password)
    select('tenant', from: 'role')
    click_on('Log In')
    expect(page).to have_content("Welcome back, #{@user.name}!")
    expect(current_path).to eq('/')
  end
  it "can't log in with wrong role" do
    visit '/login'
    fill_in('email', with: @user.email)
    fill_in('password', with: @user.password)
    select('manager', from: 'role')
    click_on('Log In')
    expect(page).to have_content("Password or email not recognized")
    expect(current_path).to eq('/login')
  end
  it "can't login in with wrong password" do
    visit '/login'
    fill_in('email', with: @user.email)
    fill_in('password', with: @user.password + 'wrong')
    click_on('Log In')
    expect(page).to have_content("Password or email not recognized")
    expect(current_path).to eq('/login')
  end
  it "can logout" do
    visit '/logout'
    expect(page).to have_content('Logged out')
    expect(current_path).to eq('/login')
  end
end
