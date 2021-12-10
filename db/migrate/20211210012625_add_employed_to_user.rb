class AddEmployedToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :employed, :boolean
  end
end
