class AnnualLeaveChangeRecord < ActiveRecord::Base
  belongs_to :employee

	KIND_USED = 1
	KIND_EXTRA = 2
end
