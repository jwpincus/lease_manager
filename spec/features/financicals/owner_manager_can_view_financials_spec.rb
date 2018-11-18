require 'rails_helper'

RSpec.feature 'Owner or manager can: ', type: :feature do
  let(:owner) { create(:owner) }
  let(:tenant) { create(:user) }
  let(:lease) { create(:lease) }
  let(:manager) { create(:manager) }

  scenario 'see financials dashboard' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(lease.owner)
    visit root_path
    click_on('Financial Dashboard')
    expect(page).to have_current_path(financials_path)
  end

end
