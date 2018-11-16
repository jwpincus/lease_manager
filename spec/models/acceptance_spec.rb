require 'rails_helper'

RSpec.describe Acceptance, type: :model do
  it { should have_one(:lease)}
  it { should have_one(:tenant)}
end
