class RenameColumnTypeToAnnualLeaveChangeRecords < ActiveRecord::Migration
  def change
		rename_column :annual_leave_change_records, :type, :kind
  end
end
