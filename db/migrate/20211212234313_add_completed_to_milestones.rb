class AddCompletedToMilestones < ActiveRecord::Migration[6.1]
  def change
    add_column :milestones, :completed, :boolean
  end
end
