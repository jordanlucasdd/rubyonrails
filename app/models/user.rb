class User < ApplicationRecord


  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
    end
  end

  def self.find_by_email_without_domain(email_address)
    email_without_domain = email_address.gsub(/@.*/,"")
    self.where("email like '%#{email_without_domain}%'").first
  end

  def is_admin?
    self.roles.include? 'ADMIN'
  end


end
