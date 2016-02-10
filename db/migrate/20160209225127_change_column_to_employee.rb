class ChangeColumnToEmployee < ActiveRecord::Migration
  def change
		change_column :employees, :last_year_left, :float
  end
end
