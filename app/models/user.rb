class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  has_secure_password
  
  def name
    [first_name.capitalize, last_name.capitalize].join(' ')
  end
end
