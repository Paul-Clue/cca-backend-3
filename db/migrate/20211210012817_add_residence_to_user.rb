class AddResidenceToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :residence, :string
  end
end
