RSpec.describe 'Post can:' do
  before :each do
    @user = create(:user)
  end

  it "be created by logged in user" do
    visit '/login'
    fill_in('email', with: @user.email)
    fill_in('password', with: @user.password)
    click_on('Log In')
    visit '/posts/new'
    fill_in 'post_title', with: "Test title"
    fill_in 'post_body', with: "Test text"
    click_on 'Save Post'
    expect(page).to have_content('Test title')
    expect(page).to have_content('Test text')
    expect(current_path).to eq("/posts/#{Post.last.id}")
  end
end
