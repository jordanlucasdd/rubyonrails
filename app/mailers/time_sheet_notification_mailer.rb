class TimeSheetNotificationMailer < ApplicationMailer

  def request_approval(ts_id)
    ts = TimeSheets::Repositories::TimeSheets.new.get(ts_id)
    @ts = TimeSheetPresenter.new(ts)
    send_mail to: @ts.project.manager.email.downcase, subject: "TS EloGroup - Aprovação"
  end

  def disapproval(ts_id)
    ts = TimeSheets::Repositories::TimeSheets.new.get(ts_id)
    @ts = TimeSheetPresenter.new(ts)
    send_mail to: ts.user.email, subject: "TS EloGroup - Recusa"
  end

end
