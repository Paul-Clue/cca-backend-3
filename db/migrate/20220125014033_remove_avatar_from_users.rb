class RemoveAvatarFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :avatar, :json
  end
end
