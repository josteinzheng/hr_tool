class ChangeColumnToAnnualLeaveChangeRecords < ActiveRecord::Migration
  def change
		change_column :annual_leave_change_records, :type, :integer
		change_column :annual_leave_change_records, :number, :float
  end
end
