class AddManagerToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :manager, :string
  end
end
