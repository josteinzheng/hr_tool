class AnnualLeaveChangeRecordsManageController < ApplicationController
	before_action :logged_in_user
	
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

	def export
		from_date = Date.parse(params[:export_params][:from_date])
		to_date = Date.parse(params[:export_params][:to_date]) + 1
		@records = AnnualLeaveChangeRecord.all.where(kind: AnnualLeaveChangeRecord::KIND_USED, when: from_date..to_date)
		respond_to do |format|
			format.xls
		end
	end
end
