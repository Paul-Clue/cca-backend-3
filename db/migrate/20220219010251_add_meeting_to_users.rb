class AddMeetingToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :meeting, :string
  end
end
