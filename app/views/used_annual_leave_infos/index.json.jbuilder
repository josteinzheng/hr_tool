json.array!(@used_annual_leave_infos) do |used_annual_leave_info|
  json.extract! used_annual_leave_info, :id, :when, :number, :whichyear, :employee_id
  json.url used_annual_leave_info_url(used_annual_leave_info, format: :json)
end
