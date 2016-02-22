class EmployeesManageController < ApplicationController
	before_action :logged_in_user

	def index
		@employee_import = EmployeeImport.new
	end

	def create
		@employee_import = EmployeeImport.new(params[:employee_import])
		if @employee_import.save
			redirect_to root_url, notice: "Imported employees successfully."
		else
			render :index
		end
	end

	def clear
		if Employee.destroy_all
			redirect_to root_url
		else
			render :index
		end
	end

	def export
		@employees = Employee.all
		respond_to do |format|
			format.xls
		end
	end
end
