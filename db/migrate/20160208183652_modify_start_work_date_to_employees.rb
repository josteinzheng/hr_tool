class ModifyStartWorkDateToEmployees < ActiveRecord::Migration
  def change
		change_table :employees do |t|
			t.remove :start_work_date
			t.integer :start_work_year
		end
  end
end
