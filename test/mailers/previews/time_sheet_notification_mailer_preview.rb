# Preview all emails at http://localhost:3000/rails/mailers/time_sheet_notification_mailer
class TimeSheetNotificationMailerPreview < ActionMailer::Preview

  def request_approval
    model = TimeSheetModel.where(status: 'waiting-approval').last
    ts = TimeSheets::Builders::TimeSheet.new.build(model)
    TimeSheetNotificationMailer.request_approval(ts)
  end

  def disapproval
    model = TimeSheetModel.where(status: 'disapproved').last
    ts = TimeSheets::Builders::TimeSheet.new.build(model)
    TimeSheetNotificationMailer.disapproval(ts)
  end

end
