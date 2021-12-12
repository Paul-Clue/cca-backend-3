class CreateMilestones < ActiveRecord::Migration[6.1]
  def change
    create_table :milestones do |t|
      t.string :title
      t.text :instructions
      t.string :user_id
      t.boolean :done?

      t.timestamps
    end
  end
end
