class AnnualLeaveChangeRecordsManageController < ApplicationController
	def index
		@record_import = AnnualLeaveChangeRecordImport.new
	end

	def import
		@record_import = AnnualLeaveChangeRecordImport.new(params[:annual_leave_change_record_import])
		if @record_import.save
			redirect_to root_url, notice: "Imported records successfully."
		else
			render :index
		end
	end
end
