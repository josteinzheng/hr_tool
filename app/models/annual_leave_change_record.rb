class AnnualLeaveChangeRecord < ActiveRecord::Base
  belongs_to :employee
  default_scope -> { order(employee_id: :ASC, when: :DESC) }
  validates :kind, presence: true,
	                  inclusion: { in: [1, 2] }
  validates :when, presence: true
  validates :number, presence: true,
                      numericality: true

	KIND_USED = 1
	KIND_EXTRA = 2


	COLUMN_STAFFNO = 'staffno'
	COLUMN_KIND = 'kind'
	COLUMN_WHEN = 'when'
	COLUMN_NUMBER = 'number'
end
