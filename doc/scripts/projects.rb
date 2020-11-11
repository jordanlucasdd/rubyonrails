# TS ANTIGO
columns = [:id, :name, :gfp_id, :responsible_for_approval, :cost_center]
file = CSV.generate(headers: true) do |csv|
  csv << columns
  Project.all.each do |obj|
    csv << [obj.id,obj.name,obj.gfp_project_id,obj.responsible_for_approval.email,obj.cost_center]
  end
end

File.write('/home/ubuntu/projects.csv',file)


# NOVO

#TS NOVO
@erros = []
require 'csv'
# path = "#{Rails.root}/doc/projects.csv"
path = "/home/ubuntu/projects.csv"


@csv = CSV.read(path, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all, col_sep: ','})
@csv.each_with_index do |row,index|

  prj = ProjectModel.where(old_ts_id: row[:id]).first_or_initialize
  user = User.find_by email: row[:responsible_for_approval]
  prj.responsible_for_approval_id = user.id if user
  prj.name = row[:name]
  prj.gfp_id = row[:gfp_id]
  prj.old_gfp_id = prj.gfp_id
  prj.old_ts_id = row[:id]
  prj.old_cc = row[:cost_center]
  prj.save
end
