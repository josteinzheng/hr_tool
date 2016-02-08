class Employee < ActiveRecord::Base
	has_many :annual_leave_change_records

	#当前工龄
	attr_accessor :seniority

	def seniority
		@seniority.nil? ? Time.now.year.to_i - self.start_work_year.to_i : @seniority
	end

	before_save {
		puts "seniroity is #{@seniority}, year is #{Time.now.year.to_i}"
		self.start_work_year = Time.now.year.to_i - @seniority.to_i
		self.statutory = getStatutory
	}

	# 根据开始工作时间计算法定年假
	# （导入的原始数据是当前工龄，需要换算成开始工作时间再进行计算，存入的也是开始工作时间）
	def getStatutory
		seniority = self.seniority.to_i
		if seniority >= 1 && seniority < 10
			statutory = 5
		elsif seniority >= 10 && seniority < 20
			statutory = 10
		elsif seniority >= 20
			statutory = 15
		else
			statutory = 0
		end
	end

end
