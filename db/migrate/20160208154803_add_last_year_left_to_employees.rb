class AddLastYearLeftToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :last_year_left, :integer
  end
end
