RSpec.describe 'With valid user:' do
  before :each do
    @user = create(:user)
  end
  it "can log in" do
    visit '/login'
    fill_in('email', with: @user.email)
    fill_in('password', with: @user.password)
    click_on('Log In')
    expect(page).to have_content("Welcome back, Test!")
    expect(current_path).to eq('/')
  end
  it "can't login in with wrong password" do
    visit '/login'
    fill_in('email', with: @user.email)
    fill_in('password', with: @user.password + 'wrong')
    click_on('Log In')
    expect(page).to have_content("Password or email not recognized")
    expect(current_path).to eq('/login')
  end
end
