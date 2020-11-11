# TS ANTIGO
columns = [:id, :month, :year, :user_id, :project_id, :created_at, 
           :updated_at, :hour, :status, :reason_for_disapproval, :percentage]

file = CSV.generate(headers: true) do |csv|
  csv << columns
  TimeSheet.all.each do |ts|
    csv << [ts.id, ts.month_reference, ts.year_reference, ts.user_id, ts.project_id, ts.created_at, 
            ts.updated_at, ts.hours_spent, ts.status, ts.reason_for_disapproval, ts.percentage_hours]
  end
end

File.write('/home/ubuntu/ts.csv',file)


require 'csv'

# path = "#{Rails.root}/doc/ts.csv"
path = "/home/ubuntu/ts.csv"
TimeSheetModel.record_timestamps = false

@csv = CSV.read(path, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all, col_sep: ','})

@csv.each_with_index do |row,index|  
  ts = prj = TimeSheetModel.where(old_ts_id: row[:id]).first_or_initialize
  prj = ProjectModel.find_by old_ts_id: row[:project_id]
  user = User.find_by old_ts_id: row[:user_id]
  ts.project_id = prj.id
  ts.user_id = user.id
  ts.month = row[:month]
  ts.year = row[:year]
  ts.hours = row[:hour]
  ts.percentage = row[:percentage]
  ts.updated_at = row[:updated_at]
  ts.created_at = row[:created_at]
  ts.reason_for_disapproval = row[:reason_for_disapproval]
  ts.status = row[:status]
  ts.save
end


@erros = []
TimeSheetModel.where(year: 2019).each do |ts|
  begin
    ts.hours = TimeSheets::UseCases::CalculateHour.new(time_sheet:ts).execute
    ts.save
  rescue Exception => e
    @erros << "TS #{ts.id} - #{ts.user.email}  : #{e}"
  end
  
end
erp = ::ErpApi::Employees.new
rep = TimeSheets::Repositories::TimeSheets.new
TimeSheetModel.where(year: 2019).each do |ts|
  contract = erp.get_contract(email: ts.user.email, year: ts.year, month: ts.month)
  rep.update_employee_contract(id:ts.id, contract: contract) if contract
end