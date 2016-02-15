class QueryController < ApplicationController
  def index
		@empty_param = params[:employee_number].blank?
		if !@empty_param
			@employee = Employee.find_by(staffno: params[:employee_number])
		end
  end
end
