class Employee < ActiveRecord::Base
	has_many :annual_leave_change_records

	#当前工龄
	attr_accessor :seniority, :statutory, :extra, :bonus, :used, :remain

	def seniority
		@seniority.nil? ? Time.now.year.to_i - self.start_work_year.to_i : @seniority
	end

	before_save {
		self.start_work_year = Time.now.year.to_i - self.seniority.to_i
	}

	after_find do |employee|
		employee.statutory = getStatutory
	end

	#TODO 起始计算日期可配置，应从数据库读取
	DAY_ANNUAL_LEAVE_CALCULATE_FROM = Time.new(2015, 1, 1)
	# 根据开始工作时间和入职日期计算法定年假
	# （导入的原始数据是当前工龄，需要换算成开始工作时间再进行计算，存入的也是开始工作时间）
	def getStatutory
		return 0.0 if in_three_months
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

		elapseddays = elapsed_days(self.hiredate > DAY_ANNUAL_LEAVE_CALCULATE_FROM ? self.hiredate : DAY_ANNUAL_LEAVE_CALCULATE_FROM,
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

end
