class RemoveColumnToEmployees < ActiveRecord::Migration
  def change
		remove_column :employees, :statutory, :integer
		remove_column :employees, :extra, :integer
		remove_column :employees, :bonus, :integer
		remove_column :employees, :used, :integer
		remove_column :employees, :remain, :integer
  end
end
