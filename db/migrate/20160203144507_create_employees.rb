class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :staffno
      t.datetime :start_work_date
      t.datetime :hiredate
      t.integer :statutory
      t.integer :extra
      t.integer :bonus
      t.integer :used
      t.integer :remain

      t.timestamps null: false
    end
  end
end
