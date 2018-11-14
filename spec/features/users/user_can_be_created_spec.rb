RSpec.feature 'On user creation:', type: :feature do
    it "can be created with valid parameters" do
      visit '/signup'
      fill_in("user_first_name", with: 'test')
      fill_in("user_last_name", with: 'test_last')
      fill_in("user_email", with: 'test@test.com')
      fill_in("user_password", with: 'password')
      fill_in("user_password_confirmation", with: 'password')
      click_on("Take me to the playground!")

      expect(User.last.first_name).to eq('test')
      expect(User.last.last_name).to eq('test_last')
      expect(User.last.email).to eq('test@test.com')
      expect(current_path).to eq('/')
    end
    it "can't be created without a name" do
      visit '/signup'
      fill_in("user_first_name", with: '')
      fill_in("user_email", with: 'test@test.com')
      fill_in("user_password", with: 'password')
      fill_in("user_password_confirmation", with: 'password')
      click_on("Take me to the playground!")

      expect(User.last).to eq(nil)
      expect(current_path).to eq('/signup')
      expect(page).to have_text('can\'t be blank')
    end
    it "can't be created without a matching password" do
      visit '/signup'
      fill_in("user_first_name", with: 'test')
      fill_in("user_email", with: 'test@test.com')
      fill_in("user_password", with: 'password')
      fill_in("user_password_confirmation", with: 'password_confirmation')
      click_on("Take me to the playground!")

      expect(User.last).to eq(nil)
      expect(current_path).to eq('/signup')
      expect(page).to have_text('doesn\'t match')
    end
end
