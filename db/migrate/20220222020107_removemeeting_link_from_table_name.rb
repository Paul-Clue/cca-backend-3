class RemovemeetingLinkFromTableName < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :meetingLink
  end

  def down
    add_column :users, :meetingLink, :string
  end
end
