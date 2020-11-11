module Api
  class TimeSheetsController < Api::ApiController

    def index
      date = Date.today 
      times = TimeSheetModel.where(:month => date.month, :year => date.year)
      render json: times.map { |ts| TimeSheetMapper.new(ts).map }
    end

    def all_by_project_gfp
      begin
        @time_sheets = TimeSheetModel.joins(:project).where("projects.old_gfp_id = ?", params[:project_id])  
        render json: @time_sheets.map { |ts| TimeSheetMapper.new(ts).map }
      rescue ActiveRecord::RecordNotFound
        render json: {error: "No time sheet was found given the identity supplied!"}
      end
    end

    def by_project_gfp
      begin
        @start_date = params[:start_date].to_date.beginning_of_month
        @end_date = params[:end_date].to_date.end_of_month
        @time_sheets = TimeSheetModel.joins(:project).where("projects.old_gfp_id = ?", params[:project_id])
        @time_sheets = @time_sheets.select{|x|
                                            dt = Date.new(x.year, x.month, 1)
                                            dt.between?(@start_date, @end_date)
                                          }
        render json: @time_sheets.map { |ts| TimeSheetMapper.new(ts).map }
      rescue ActiveRecord::RecordNotFound
        render json: {error: "No time sheet was found given the identity supplied!"}
      end
    end

    def register_time_sheet
      user_email = params[:user_email]
      gfp_project_id = params[:gfp_project_id] 
      hours_spent = params[:hours_spent].to_i
      year = params[:year].to_i
      month = params[:month].to_i

      begin
        user = User.find_by_email_without_domain(user_email)
        raise Exception, "User not found" if user.blank?

        project = ProjectModel.find_by_gfp_project_id(gfp_project_id)
        raise Exception, "Project not found" if project.blank?

        unless user.projects.include?(project)
          user.projects << project
          user.save!
          user.reload
        end
        spent_registration = TimeSheets::TimeSpentRegistration.new(user, project, Date.new(year, month, 1))
        time_sheet = spent_registration.register_time_spent!(hours_spent, false)
        spent_registration.send_for_approval!(UserMailer, false)
        render json: {ok: "Time sheet successfully registered!"}
      rescue Exception => e
        render json: {error: e.message} 
      end
    end

    def by_user_email_in_period
      begin
        start_date = params[:start_date].to_date.beginning_of_month
        end_date = params[:end_date].to_date.end_of_month
        user_email = params[:email]

        user = User.find_by_email_without_domain(user_email)
        raise Exception, "User not found" if user.blank?
        time_sheets = TimeSheetModel.where(user_id: user.id)
        time_sheets = user.time_sheets.select{|x|
                                  dt = Date.new(x.year, x.month, 1)
                                  dt.between?(start_date, end_date)
                                }


        render json: time_sheets.map { |ts| TimeSheetMapper.new(ts).map }

      rescue Exception => e
        render json: {error: e.message} 
      end
    end

    def by_user_email_in_date
      begin
        year = params[:year].to_i
        month = params[:month].to_i
        user_email = params[:email]

        user = User.find_by_email_without_domain(user_email)
        raise Exception, "User not found" if user.blank?
        time_sheets = TimeSheetModel.where(user_id: user.id).where(:month => month, :year => year)
        

        render json: time_sheets.map { |ts| TimeSheetMapper.new(ts).map }

      rescue Exception => e
        render json: {error: e.message} 
      end
    end


  end
end