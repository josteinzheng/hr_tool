class Employee < ActiveRecord::Base
	has_many :used_annual_leave_infos
end
