class EmployeesManageController < ApplicationController
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
end
