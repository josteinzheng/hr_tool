class Employee < ActiveRecord::Base
	has_many :annual_leave_change_records, dependent: :destroy
	default_scope -> { order(staffno: :ASC) }

	validates :name, presence: true
	validates :staffno, uniqueness: true,
											length: { is: 8 }
	validates :hiredate, presence: true
	validates :seniority, numericality: {
													only_integer: true,
													greater_than_or_equal_to: 0,
													less_than_or_equal_to: 35
												}

	validates :last_year_left, presence: true,
															numericality: true

	#当前工龄
	attr_accessor :seniority, #工龄
	              :statutory, #法定年假
	              :extra, #额外年假
	              :bonus, #公司福利年假
	              :used, #已休年假
	              :remain #剩余年假

	COLUMN_NAME = 'name'                        #姓名
	COLUMN_STAFFNO = 'staffno'                  #员工号
	COLUMN_SENIORITY = 'seniority'              #工龄
	COLUMN_HIREDATE = "hiredate"                #入职日期
	COLUMN_LAST_YEAR_LEFT = "last_year_left"    #去年剩余年假

	before_save {
		self.start_work_year = Time.now.year.to_i - self.seniority.to_i
	}

	after_find do |employee|
		employee.seniority = Time.now.year.to_i - self.start_work_year.to_i;
		includeLastYear = Setting.first.includeLastYear
		if includeLastYear
			initAnnualLeaveInfoIncludeLastYear(employee)
		else
			initAnnualLeaveInfoWithoutLastYear(employee)
		end
	end

	def initAnnualLeaveInfoIncludeLastYear(employee)
		employee.last_year_left ||= 0.0
		employee.statutory = 0.0
		employee.bonus = 0.0

		this_year_i = Time.now.year.to_i
		last_year_i = this_year_i - 1
		employee.extra = employee.annual_leave_change_records.where(
			kind: AnnualLeaveChangeRecord::KIND_EXTRA, which_year: (last_year_i..this_year_i)).sum(:number)
		employee.used = employee.annual_leave_change_records.where(
			kind: AnnualLeaveChangeRecord::KIND_USED, which_year: (last_year_i..this_year_i)).sum(:number)
		employee.statutory = getStatutory
		employee.bonus = getBonus(employee)
		employee.remain = employee.last_year_left + employee.statutory + employee.extra + employee.bonus - employee.used
	end


	def initAnnualLeaveInfoWithoutLastYear(employee)
		employee.last_year_left = 0.0
		employee.statutory = 0.0
		employee.bonus = 0.0

		this_year_i = Time.now.year.to_i
		last_year_i = this_year_i - 1
		employee.extra = employee.annual_leave_change_records.where(
			kind: AnnualLeaveChangeRecord::KIND_EXTRA, which_year: this_year_i).sum(:number)
		employee.used = employee.annual_leave_change_records.where(
			kind: AnnualLeaveChangeRecord::KIND_USED,  which_year: this_year_i).sum(:number)
		employee.statutory = getStatutory
		employee.bonus = getBonus(employee)
		employee.remain = employee.last_year_left + employee.statutory + employee.extra + employee.bonus - employee.used
	end

	def getStatutoryBase
		seniority = self.seniority.to_i
		if seniority >= 1 && seniority < 10 #累计工作满一年不满10年的
			statutory_base = 5
		elsif seniority >= 10 && seniority < 20 #已满10年不满20年
			statutory_base = 10
		elsif seniority >= 20 #年满20年的
			statutory_base = 15
		else
			statutory_base = 0
		end
		statutory_base
	end

	DAY_ANNUAL_LEAVE_CALCULATE_FROM = Time.new(Time.now.year, 1, 1)
	# 根据开始工作时间和入职日期计算法定年假
	# （导入的原始数据是当前工龄，需要换算成开始工作时间再进行计算，存入的也是开始工作时间）
	def getStatutory
		statutory_base = getStatutoryBase

		elapseddays = elapsed_days(self.hiredate > DAY_ANNUAL_LEAVE_CALCULATE_FROM ?
			                           self.hiredate : DAY_ANNUAL_LEAVE_CALCULATE_FROM,
															Time.now)

		#年假最小单位为0.5天
		(elapseddays * statutory_base / 365.0 * 2).to_i / 2.0
	end

	#入职日期是否在三个月之内
	def in_three_months
		self.hiredate > DateTime.now.prev_month(3)
	end

	#返回相差的天数
	def elapsed_days(from, to)
		((to - from) / 24.hours ).to_i
	end

	#公司福利年假
	def getBonus(employee)
		now = Time.now
		bonus = 0.5 * (now.year - employee.hiredate.year - 1)
		bonus < 0 ? 0 : bonus
	end

end
