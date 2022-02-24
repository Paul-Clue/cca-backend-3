class AddMeetingLinkToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :meeting_link, :string
  end
end
