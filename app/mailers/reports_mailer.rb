class ReportsMailer < ApplicationMailer

  def allocations(date:,path:,errors:)
    @date = date
    file = File.open(path)
    attachments[File.basename(file)] = file.read
    @errors = errors
    send_mail to: APP_CONFIG::REPORT_EMAIL, subject: "TS EloGroup - Relatório de alocações v2 #{date}"
    file.close
  end

end
