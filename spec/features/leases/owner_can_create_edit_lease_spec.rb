RSpec.feature 'Owner can: ', type: :feature do
  let(:owner) { create(:owner) }
  let(:tenant) { create(:user) }
  let(:lease) { create(:lease) }
  let(:manager) { create(:manager) }
  
  scenario 'create a new lease' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(owner)
    visit '/leases/new'
    expect(current_path).to eq('/leases/new')
    fill_in('lease_address_line_1', with: 'Unit 123')
    fill_in('lease_address_line_2', with: '123 Main st')
    fill_in('lease_city', with: 'NY')
    fill_in('lease_state', with: 'NY')
    fill_in('lease_zip', with: '01010')
    fill_in('lease_amount', with: 1500.00)
    select('31', from: 'lease_payment_day').select_option
    click_on("Create New Lease")
    
    expect(Lease.last.address_line_1).to eq('Unit 123')
    expect(Lease.last.owner.id).to eq(owner.id)
    expect(current_path).to eq(lease_path(Lease.last))
  end
  
  scenario 'add a manager with an account to a lease' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(lease.owner)
    visit lease_path(lease)
    fill_in('manager_email', with: manager.email)
    click_on('Add Manager to Lease')
    expect(current_path).to eq(lease_path(lease))
    expect(page.body).to include(manager.name)
  end
  
  scenario 'add a manager without an account to a lease' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(lease.owner)
    manager_email = Faker::Internet.unique.email
    visit lease_path(lease)
    fill_in('manager_email', with: manager_email)
    click_on('Add Manager to Lease')
    expect(current_path).to eq(lease_path(lease))
    expect(page.body).to include(manager_email)
  end
  
  scenario 'add a tenant with an account to a lease' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(lease.owner)
    visit lease_path(lease)
    fill_in('tenant_email', with: tenant.email)
    click_on('Add Tenant to Lease')
    expect(current_path).to eq(lease_path(lease))
    expect(page.body).to include(tenant.name)
  end
  
  scenario 'add a tenant without an account to a lease' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(lease.owner)
    tenant_email = Faker::Internet.unique.email
    visit lease_path(lease)
    fill_in('tenant_email', with: tenant_email)
    click_on('Add Tenant to Lease')
    expect(current_path).to eq(lease_path(lease))
    expect(page.body).to include(tenant_email)
  end
  
  
  
end