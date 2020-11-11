class ApiError < RuntimeError

  attr_reader :code, :error, :data

  def initialize(code:,error:,data:)
    @code = code
    @error = error
    @data = data
  end

end