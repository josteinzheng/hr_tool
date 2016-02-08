class CreateAnnualLeaveChangeRecords < ActiveRecord::Migration
  def change
    create_table :annual_leave_change_records do |t|
      t.string :type
      t.datetime :when
      t.integer :number
      t.datetime :which_year
      t.references :employee, index: true

      t.timestamps null: false
    end
    add_foreign_key :annual_leave_change_records, :employees
  end
end
