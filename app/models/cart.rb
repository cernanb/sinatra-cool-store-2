class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :items

  def total
    items.inject(0) { |sum, item| sum += item.price }
  end

	def checkout
		user = User.find_by_id(self.user_id)
		self.items.each do |item|
			user.total_spent += item.price.to_i
			item.inventory -= 1
			user.save
			item.save
		end
		user.save
		self.status = "submitted"
	end
end
