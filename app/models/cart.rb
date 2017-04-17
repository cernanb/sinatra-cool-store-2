class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :items

  def total
    items.inject(0) { |sum, item| sum += item.price }
  end

  def checkout
    items.each do |item|
      item.inventory -= 1
    end
    user.update_total_spent(total)
    self.status = 'submitted'
  end
end
