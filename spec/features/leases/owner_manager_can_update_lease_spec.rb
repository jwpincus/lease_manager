RSpec.feature 'Owner can: ', type: :feature do
  let(:owner) { create(:owner) }
  let(:tenant) { create(:user) }
  let(:lease) { create(:lease) }
  let(:manager) { create(:manager) }

  scenario 'owner can edit lease' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(lease.owner)
    visit edit_lease_path(lease)
    fill_in('lease_address_line_1', with: 'test update')
    click_on("Save Changes")
    lease.reload

    expect(lease.address_line_1).to eq('test update')
    expect(page).to have_current_path(lease_path(lease))
  end

  scenario 'manager can edit lease' do
    lease.managers << manager
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(manager)
    visit edit_lease_path(lease)
    fill_in('lease_address_line_1', with: 'test update')
    click_on("Save Changes")
    lease.reload

    expect(lease.address_line_1).to eq('test update')
    expect(page).to have_current_path(lease_path(lease))
  end

  scenario 'tenant can\'t edit lease' do
    lease.tenants << tenant
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(tenant)
    visit edit_lease_path(lease)
    expect(page).to have_current_path(lease_path(lease))
  end


end
