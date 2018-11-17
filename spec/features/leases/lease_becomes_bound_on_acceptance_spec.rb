require 'rails_helper'

RSpec.feature 'Lease:', type: :feature do
  let(:owner) { create(:owner) }
  let(:tenant) { create(:user) }
  let(:lease) { create(:lease) }
  let(:manager) { create(:manager) }

  scenario 'Cannot be edited after all acceptances' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(lease.owner)
    lease.tenants << tenant
    tenant.accept_lease!(lease)
    visit leases_path

    expect(page).to_not have_content('Edit Lease')
    visit(edit_lease_path(lease))
    expect(page).to have_current_path(lease_path(lease))
    expect(page).to have_content('The lease has been accepted by all tenants. It can no longer be updated')
  end

end
