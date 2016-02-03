json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :staffno, :start_work_date, :hiredate, :statutory, :extra, :bonus, :used, :remain
  json.url employee_url(employee, format: :json)
end
