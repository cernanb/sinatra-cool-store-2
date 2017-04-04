class AddTotalSpentToUsers < ActiveRecord::Migration
  def change
		add_column :users, :total_spent, :integer, default: 0
  end
end
