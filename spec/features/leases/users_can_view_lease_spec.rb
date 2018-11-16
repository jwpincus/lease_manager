RSpec.feature 'Owner can: ', type: :feature do
  let(:owner) { create(:owner) }
  let(:tenant) { create(:user) }
  let(:lease) { create(:lease) }
  let(:manager) { create(:manager) }
  
  scenario 'owner can view lease' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(lease.owner)
    visit '/leases'
    expect(page.body).to have_content(lease.address_line_1)
    visit lease_path(lease)
    expect(page.body).to have_content(lease.address_line_1)
  end
  
  scenario 'manager can view lease' do
    lease.managers << manager
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(lease.managers.first)
    visit '/leases'
    expect(page.body).to have_content(lease.address_line_1)
    visit lease_path(lease)
    expect(page.body).to have_content(lease.address_line_1)
  end
  
  scenario 'tenant can view lease' do
    lease.tenants << tenant
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(lease.tenants.first)
    visit '/leases'
    expect(page.body).to have_content(lease.address_line_1)
    visit lease_path(lease)
    expect(page.body).to have_content(lease.address_line_1)
  end
  
  scenario 'unassociated user can\'t see lease' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(tenant)
    visit '/leases'
    expect(page.body).not_to have_content(lease.address_line_1)
    visit lease_path(lease)
    expect(page.body).not_to have_content(lease.address_line_1)
  end
  
  scenario "non-logged in user is redirected to login" do
    visit '/leases'
    expect(page.body).to have_content('must be signed in')
    expect(current_path).to eq(root_path)
  end
  
end