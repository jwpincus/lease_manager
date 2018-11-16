class LeaseUser < ApplicationRecord
  belongs_to :lease
  belongs_to :user
  belongs_to :acceptance
  
end
