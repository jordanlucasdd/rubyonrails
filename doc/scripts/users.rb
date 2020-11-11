# TS ANTIGO
columns = [:id, :name, :email, :admin, :erp_id]
file = CSV.generate(headers: true) do |csv|
  csv << columns
  User.order(:name).each do |obj|
    csv << [obj.id,obj.name,obj.email,obj.admin, obj.erp_id]
  end
end

File.write('/home/ubuntu/users.csv',file)


columns = [:id, :projects]
file = CSV.generate(headers: true) do |csv|
  csv << columns
  User.all.each do |obj|
    csv << [obj.id,obj.projects.pluck(:id).join('#')]
  end
end

File.write('/home/ubuntu/user_projects.csv',file)




#TS NOVO
require 'csv'
# path = "#{Rails.root}/doc/users.csv"
path = "/home/ubuntu/users.csv"

@csv = CSV.read(path, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all, col_sep: ','})
@csv.each_with_index do |row,index|
  user = User.where(email:row[:email]).first_or_initialize
  user.old_ts_id = row[:id]
  user.name = row[:name]
  user.erp_id = row[:erp_id]
  user.roles = (row[:admin] == true) ? ["ADMIN"] : []
  user.save
end


#AVATAR
User.all.each do |user|
  begin
    dto = Intranet::Profile.new.get_by_email(user.email)
    user.update_attribute(:avatar,dto['avatar'])
  rescue Exception => e
    user.update_attribute(:avatar,nil)
  end
end





#USER PROJECTS após rodar carga de projetos
#TS ANTIGO


require 'csv'
# path = "#{Rails.root}/doc/user_projects.csv"
path = "/home/ubuntu/user_projects.csv"

@csv = CSV.read(path, { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all, col_sep: ','})
@csv.each_with_index do |row,index|
  user = User.find_by old_ts_id: row[:id]
  ids = row[:projects].to_s.split('#')
  prjs = ProjectModel.where(old_ts_id: ids)
  user.recent_projects = prjs.pluck(:id)
  user.save
end

