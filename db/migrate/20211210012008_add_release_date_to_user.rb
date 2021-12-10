class AddReleaseDateToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :release_date, :date
  end
end
