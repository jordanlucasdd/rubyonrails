





emails = User.all.map { |u| u.email.upcase }
users2 = User.where(email: emails)

users2.each do |u|
  u.email = u.email.downcase
  u.save
end

doubles = []
users.each do |u|
  i = 0
  ud = User.find_by email: u.email.downcase
  uu = User.find_by email: u.email.upcase
  i += 1 if ud
  i += 1 if uu
  if i > 1
    doubles << [ud.id,uu.id]
  end

end


teste = [[1883, 1375]]
doubles.each do |t|
  TimeSheetModel.where(user_id: t[1]).update_all(user_id:t[0])
end

intranet = Intranet::Profile.new
data = intranet.get_by_email "juliana.costa@elogroup.com.br"


doubles.each do |t|
  if TimeSheetModel.where(user_id: t[1]).count == 0
    u = User.find t[1]
    u.destroy
  else
    p t[1]
  end
end

[[1883, 1375], [1900, 1358], [1895, 1431], [1879, 1424], [1886, 1445], [1878, 1439], [1906, 1471], 
 [1877, 1462], [1869, 1509], [1901, 1544], [1882, 1543], [1911, 1580], [1876, 1575], [1903, 1614], [1889, 1631], 
 [1904, 1629], [1892, 1595], [1880, 1650], [1871, 1724], [1887, 1719], [1907, 1684], [1896, 1703], [1873, 1710], [1885, 1797], 
 [1909, 1853], [1872, 1830], [1890, 1611], [1884, 1669], [1902, 1478], [1897, 1823]]




Perseu Menezes
u = User.find_by email: "perseu.menezes@elogroup.com.br"
tss = TimeSheetModel.where(month:9,year:2019,status:'waiting-approval').joins(:project).where("projects.responsible_for_approval_id = ?",u.id)
tss.each do |ts|
  p "#{ts.id} #{ts.user.email} #{ts.user.name}"
end


TimeSheetModel.where(status:'approved').where(year:2019).where(month:5).limit(15).each do |ts|
  prj = ts.project
  prj.update_attribute(:responsible_for_approval_id, u.id)
end


aws_access_key_id = 'AKIAIIWE6SUSG3IPKAEQ'
aws_secret_access_key = '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'
region: 'us-east-1'

service = S3::Service.new(:access_key_id => "AKIAIIWE6SUSG3IPKAEQ",:secret_access_key => "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")


service.buckets.find("elogroup")

object = first_bucket.objects.find("lenna.png")


connection = Fog::Storage.new({
  :provider                 => 'AWS',
  :aws_access_key_id        => 'AKIAIIWE6SUSG3IPKAEQ',
  :aws_secret_access_key    => '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'
})

dir = connection.directories.get("elogroup")

file = dir.files.get('intranet/person/avatar/681/thumb_fedaf0e37583.jpg')


 scp users.csv ubuntu@ts.elogroup.com.br:/home/ubuntu/users.csv
 scp ts.csv ubuntu@ts.elogroup.com.br:/home/ubuntu/ts.csv
 scp projects.csv ubuntu@ts.elogroup.com.br:/home/ubuntu/projects.csv



 guilherme.quadros@elogroup.com.br
juliana.costa@elogroup.com.br
maria.siqueira@elogroup.com.br
ricardo.fragoso@elogroup.com.br
thales.barne@elogroup.com.br
vicente.lotufo@elogroup.com.br
joao.chagas@elogroup.com.br
rafael.cabral@elogroup.com.br
victor.esteves@elogroup.com.br
rafael.mynssem@elogroup.com.br
rafael.mynssem@elogroup.com.br

User.where(name:nil).each do |user|
Users::UseCases::UpdateUserData.new(user).execute
end

month = 9
year = 2019
users = []
@employee_rep = Users::Repositories::Employees.new
users_with_allocation = TimeSheetModel.where(month:month,year:year).pluck(:user_id).uniq
user_without_allocation = User.where('id not in (?)',users_with_allocation)
user_without_allocation.each do |user|
  begin
    employee = @employee_rep.get_employee_in_date(user: user, month: month, year: year)
    users << employee if employee
  rescue Exception => e
    p e.code
    p e.message
  end
  
end

ts = TimeSheetModel.find 44355

CostCenterFormatter.new.mask(ts.cost_center)

TimeSheetModel.where(month:9,year:2019).each do |ts|
  ts.cost_center = ts.project.old_cc
  ts.save
end


perseu.menezes@elogroup.com.br



ts = 44450

times = []
TimeSheetModel.where(month:9,year:2019).each do |ts|
  cost_center = ts.cost_center || ""
  if cost_center.length < 11 
    times << ts.id
  end
end


'31915001100'.count

TimeSheetModel.where(status: STATUS::WAITING_APPROVAL, month:9, year:2019).each do |ts|
  ts.update_attribute(:status,STATUS::APPROVED)
end





40685
ts = TimeSheetModel.find 40685
@erp = ::ErpApi::Employees.new
data = @erp.get_contract(email: ts.user.email, year: ts.year, month: ts.month)
hire_dates = @erp.employee_hire_dates(employee_id: data['UKEY'])


{"CARGO"=>"20121227PF7ESE0S1O8S", "FUNCAO"=>"20121227PF7ESE0SP05J", "NIVEL"=>"20121227PF7ESE0S3CPC", "NOME_CARGO"=>"ESTAGIARIO", "NOME_FUNCAO"=>"ESTAGIARIO", "NOME_NIVEL"=>"ESTAGIARIO III", "TIPO_CONTRATO"=>4, "NOME_TIPO_CONTRATO"=>"Estagiario", "UKEY"=>"20150618TM4FBM0RNU88"}

{"UKEY"=>"20150618TM4FBM0RNU88", "NOME"=>"Mariana de Abreu Souza", "DATA_CONTRATACAO"=>"2015-06-22T00:00:00-03:00", "DATA_DESLIGAMENTO"=>"2016-01-08T00:00:00-02:00"}