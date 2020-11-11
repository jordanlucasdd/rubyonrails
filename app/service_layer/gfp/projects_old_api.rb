module Gfp

  class ProjectsOldApi

    def initialize
      user = APP_CONFIG::GFP::APP_ID
      pass = APP_CONFIG::GFP::API_TOKEN
      @api_url = "http://api:#{pass}@gfp-2018.elogroup.com.br/api"
    end

    def list
      response = ::RestClient.get "#{@api_url}/projects"
      JSON.parse(response)
    end

    def leader(project_id)
      response = ::RestClient.get "#{@api_url}/projects/#{project_id}/leader"
      JSON.parse(response)
    end

    def planning_employees_by_project(employee_id:,month:,year:)
      url = "#{@api_url}/projects/planning_by_employee/#{employee_id}/#{year}/#{month}.json"
      response = ::RestClient.get url
      dto = JSON.parse(response)
      if dto.class == Array
        dto
      else
        []
      end
    end

  end

end