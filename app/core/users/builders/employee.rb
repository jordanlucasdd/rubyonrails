module Users
  class Builders::Employee

    def initialize(data)
      @data = data
    end

    def build
      employee = Users::Domain::Employee.new
      employee.name = @data['NOME']
      employee.id = @data['UKEY']
      employee.function = @data['NOME_FUNCAO']
      employee.level = @data['NOME_NIVEL']
      employee.role  = @data['NOME_CARGO']
      employee.office = @data['DEPARTMENT_NAME']
      employee.hiring_date = convert_to_date(@data['DATA_CONTRATACAO'])
      employee.dismissal_date = convert_to_date(@data['DATA_DESLIGAMENTO'])
      employee.contract_type = @data['NOME_TIPO_CONTRATO']
      employee.unit = @data['DEPARTMENT_NAME']
      employee
    end

    private
      def convert_to_date(dt_str)

        if dt_str
          begin
            date = dt_str.to_date
          rescue Exception => e
            date = nil
          end
        end

        date

      end

  end
end