class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  has_many :carts

  def full_name
    "#{first_name} #{last_name}"
  end
end
