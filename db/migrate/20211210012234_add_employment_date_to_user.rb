class AddEmploymentDateToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :employment_date, :date
  end
end
