class AnnualLeaveChangeRecordsController < ApplicationController
  def index
  end

  def new
		employee = Employee.find_by_id(params[:employee_id])
		@record = employee.annual_leave_change_records.build
  end

  def create
	  record = AnnualLeaveChangeRecord.new(record_params)
	  employee = record.employee
	  last_year_remain = employee.last_year_left - employee.used
	  this_year_i = Time.now.year
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
	  else  #全部使用去年剩余年假
			record.which_year = this_year_i - 1
			record.save
	  end
	  redirect_to annual_leave_change_records_url
  end

  def destroy
  end


  private
	  # Never trust parameters from the scary internet, only allow the white list through.
	  def record_params
		  params.require(:annual_leave_change_record).permit(:kind, :when, :number, :employee_id)
	  end
end
