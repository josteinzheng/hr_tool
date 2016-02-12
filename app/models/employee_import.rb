require 'roo'

class EmployeeImport
	# switch to ActiveModel::Model in Rails 4
	extend ActiveModel::Naming
	include ActiveModel::Conversion
	include ActiveModel::Validations

	attr_accessor :file

	def initialize(attributes = {})
		attributes.each { |name, value| send("#{name}=", value) }
	end

	def persisted?
		false
	end

	def save
		if imported_employees.map(&:valid?).all?
			imported_employees.each(&:save!)
			true
		else
			imported_employees.each_with_index do |employee, index|
				employee.errors.full_messages.each do |message|
					errors.add :base, "Row #{index+2}: #{message}"
				end
			end
			false
		end
	end

	def imported_employees
		@imported_employees ||= load_imported_employees
	end

	def load_imported_employees
		spreadsheet = open_spreadsheet
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).map do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			row[Employee::COLUMN_HIREDATE] = DateTime.parse(row[Employee::COLUMN_HIREDATE].to_s)
			employee = Employee.new(row)
			employee
		end
	end

	def open_spreadsheet
		case File.extname(file.original_filename)
			when ".xlsx" then Roo::Excelx.new(file.path)
			else raise "Unknown file type: #{file.original_filename}"
		end
	end
end
