class AnnualLeaveChangeRecordsController < ApplicationController
	before_action :logged_in_user
	def index
		@records = AnnualLeaveChangeRecord.all
	end

	def new
		employee = Employee.find_by_id(params[:employee_id])
		@record = employee.annual_leave_change_records.build
		@record.kind = params[:kind]
	end

	def create
		record = AnnualLeaveChangeRecord.new(record_params)
		recordBelongsToWhichYear(record)
		redirect_to annual_leave_change_records_url
	end

##年假变动记录属于哪年，在年假清零时用用来统计
	def recordBelongsToWhichYear(record)
		this_year_i = Time.now.year
		employee = record.employee
		last_year_remain = employee.last_year_left - employee.used
		if record.kind == AnnualLeaveChangeRecord::KIND_EXTRA
			record.which_year = this_year_i
			record.save
		elsif record.kind == AnnualLeaveChangeRecord::KIND_USED
			if last_year_remain <= 0 #使用今年休假记录
				record.which_year = this_year_i
				record.save
			elsif last_year_remain < record.number #休假记录拆分成两条
				record_use_last_year = record.dup
				record_use_last_year.which_year = this_year_i - 1
				record_use_last_year.number = last_year_remain
				record_use_this_year = record.dup
				record_use_this_year.which_year = this_year_i
				record_use_this_year.number = record.number - last_year_remain
				record_use_last_year.save
				record_use_this_year.save
			else #全部使用去年剩余年假
				record.which_year = this_year_i - 1
				record.save
			end
		else
			raise "未知的年假变动类型"
		end
	end

	def destroy
		@record = AnnualLeaveChangeRecord.find_by_id(params[:id])
		if @record.destroy
			flash[:success] = "成功删除#{@record.employee.name}的休假记录"
		else
			flash[:warning] = "删除失败"
		end
		redirect_to annual_leave_change_records_path;
	end


	private
	# Never trust parameters from the scary internet, only allow the white list through.
		def record_params
			params.require(:annual_leave_change_record).permit(:kind, :when, :number, :employee_id)
		end

end
