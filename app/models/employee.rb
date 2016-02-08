class Employee < ActiveRecord::Base
	has_many :annual_leave_change_records
end
