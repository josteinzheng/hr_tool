class ChangeColumnTypeToAnnualLeaveChangeRecords < ActiveRecord::Migration
  def change
		change_column :annual_leave_change_records, :which_year, :integer
  end
end
