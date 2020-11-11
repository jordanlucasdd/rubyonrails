class SyncProjects

  def initialize()
    @logger ||= Logger.new("#{Rails.root}/log/projects_gfp#{Date.today.to_s}.log")
    @api = Gfp::ProjectsOldApi.new
  end

  def execute
    @erros = 0
    @logger.info("Executando - #{Time.zone.now}")
    dtos = get_dtos

    dtos.each do |dto|

      begin
        prj = ProjectModel.where(gfp_id: dto['id']).first_or_initialize
        prj.name = dto['name']
        prj.gfp_id = dto['id']
        prj.old_gfp_id = prj.gfp_id
        prj.old_cc = dto['cost_center']
        prj.manager = get_leader(prj.gfp_id)
        prj.active_in_gfp = (dto['project_status_id'].to_s != '2')
        prj.save

        @logger.info("Projeto #{prj.id} - #{prj.name} atualizado")
      rescue Exception => e
        @erros += 1
        if prj
          @logger.error("Erro ao atulizar projeto  #{prj.id} - #{prj.name} #{e.message}")
        else
          @logger.error("Erro ao atulizar projeto  #{dto} -  #{e.message}")
        end
      end

    end

    @logger.info("#{dtos.count} projetos atualizado - #{@erros} encontrados")

  end


  private
    def get_dtos
      begin
        dtos = @api.list
      rescue Exception => e
        @logger.error("Erro ao executar api projetos: #{e.message}")
        dtos = []
      end

      dtos
    end

    def get_gfp_status

    end

    def get_leader(project_id)

      begin
        dto = @api.leader(project_id)
        user = User.find_by_email_without_domain(dto['email']) 
        if user.nil? 
          user = User.new
          user.name = dto['name']
          user.email = dto['email']
          user.save
        end

        user
      rescue Exception => e
        @logger.error("Erro ao executar api leader: #{e.message}")
      end

      user

    end


end