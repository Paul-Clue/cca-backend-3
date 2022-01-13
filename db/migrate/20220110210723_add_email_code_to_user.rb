class AddEmailCodeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email_code, :string
  end
end
