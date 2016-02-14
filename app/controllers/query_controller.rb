class QueryController < ApplicationController
  def index
		@empty_param = params[:employee_number].blank?
		@employee = Employee.find_by(staffno: params[:employee_number])
  end
end
