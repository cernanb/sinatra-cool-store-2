class AddDefaultStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string, default: 'Non-Premium'
  end
end
