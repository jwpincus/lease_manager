require 'rails_helper'

RSpec.describe User, type: :model do
    it "is valid with valid attributes" do
      expect(User.new(
        first_name: 'test',
        last_name: 'test',
        email: 'test@test.com',
        password: 'test',
        password_confirmation: 'test',
        role: 'tenant'
        )).to be_valid
    end
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_confirmation_of(:password) }
    it "should have a role" do
      user = create(:user)
      expect(user.role).to eq('tenant')
    end
    it "should be able to be a manager" do
      user = create(:manager)
      expect(user.role).to eq('manager')
    end
    
    it "should check for invites on creation" do
      invited_user = create(:invited_user)
      lease = invited_user.lease
      user = User.create(
        first_name: 'test',
        last_name: 'test',
        email: invited_user.email,
        role: 'tenant',
        password: 'test',
        password_confirmation: 'test'
        )
      expect(user.leases.first).to eq(lease)
      expect(InvitedUser.where(id:invited_user.id).first).to eq(nil)
    end

end
