class CreateUsedAnnualLeaveInfos < ActiveRecord::Migration
  def change
    create_table :used_annual_leave_infos do |t|
      t.datetime :when
      t.integer :number
      t.string :whichyear
      t.integer :employee_id

      t.timestamps null: false
    end
  end
end
