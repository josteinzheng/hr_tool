class AnnualLeaveChangeRecord < ActiveRecord::Base
  belongs_to :employee

	KIND_USED = 1
	KIND_EXTRA = 2


	COLUMN_STAFFNO = 'staffno'
	COLUMN_KIND = 'kind'
	COLUMN_WHEN = 'when'
	COLUMN_NUMBER = 'number'
end
