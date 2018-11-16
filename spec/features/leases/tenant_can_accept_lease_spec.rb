require 'rails_helper'

RSpec.feature 'Tenant can:', type: :feature do
  let(:owner) { create(:owner) }
  let(:tenant) { create(:user) }
  let(:lease) { create(:lease) }
  let(:manager) { create(:manager) }

  scenario 'accept a lease from the lease overview page' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(tenant)
    lease.tenants << tenant
    expect(lease.acceptances.first.accepted).to be_falsey

    visit leases_path
    click_on("Accept Lease")
    lease.reload

    expect(lease.acceptances.first.accepted).to be_truthy
  end
  scenario 'accept a lease from the lease detail page' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(tenant)
    lease.tenants << tenant
    expect(lease.acceptances.first.accepted).to be_falsey

    visit lease_path(lease)
    click_on("Accept Lease")
    lease.reload

    expect(lease.acceptances.first.accepted).to be_truthy
  end


end
