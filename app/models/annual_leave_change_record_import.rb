require 'roo'

class AnnualLeaveChangeRecordImport
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
		if imported_records.map(&:valid?).all?
			imported_records.each(&:save!)
			true
		else
			imported_records.each_with_index do |record, index|
				record.errors.full_messages.each do |message|
					errors.add :base, "Row #{index+2}: #{message}"
				end
			end
			false
		end
	end

	def imported_records
		@imported_records ||= load_imported_records
	end

	def load_imported_records
		imported_records = Array.new
		spreadsheet = open_spreadsheet
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			row[AnnualLeaveChangeRecord::COLUMN_WHEN] = DateTime.parse(row[AnnualLeaveChangeRecord::COLUMN_WHEN].to_s)
			employee = Employee.find_by(staffno: row[AnnualLeaveChangeRecord::COLUMN_STAFFNO])
			row.delete(AnnualLeaveChangeRecord::COLUMN_STAFFNO)
			record = employee.annual_leave_change_records.build(row)
			imported_records.concat(recordsBelongsToWhichYear(record))
		end
		imported_records
	end

##年假变动记录属于哪年，在年假清零时用用来统计
	def recordsBelongsToWhichYear(record)
		records = Array.new
		this_year_i = Time.now.year
		employee = record.employee
		last_year_remain = employee.last_year_left - employee.used
		if record.kind == AnnualLeaveChangeRecord::KIND_EXTRA
			record.which_year = this_year_i
			records << record
		elsif record.kind == AnnualLeaveChangeRecord::KIND_USED
			if last_year_remain <= 0 #使用今年休假记录
				record.which_year = this_year_i
				records << record
			elsif last_year_remain < record.number #休假记录拆分成两条
				record_use_last_year = record.dup
				record_use_last_year.which_year = this_year_i - 1
				record_use_last_year.number = last_year_remain
				record_use_this_year = record.dup
				record_use_this_year.which_year = this_year_i
				record_use_this_year.number = record.number - last_year_remain
				records << record_use_last_year
				records << record_use_this_year
			else #全部使用去年剩余年假
				record.which_year = this_year_i - 1
				records << record
			end
		else
			raise "未知的年假变动类型"
		end
		records
	end

	def open_spreadsheet
		case File.extname(file.original_filename)
			when ".xlsx" then Roo::Excelx.new(file.path)
			else raise "Unknown file type: #{file.original_filename}"
		end
	end
end
