RSpec.feature 'Owner can:', type: :feature do
  let(:owner) { create(:owner) }
  let(:tenant) { create(:user) }
  scenario 'Owner can create a new lease' do
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
  end
  
  
end