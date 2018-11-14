RSpec.feature 'Owner can:', type: :feature do
  let(:owner) { create(:owner) }
  scenario 'Owner can create a new lease' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(owner)
  end
end