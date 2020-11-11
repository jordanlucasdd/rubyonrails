class CostCenterFormatter

  def mask(value)
    if value
      value = value.gsub('.','')
      "#{value[0..1]}.#{value[2..3]}.#{value[4..5]}.#{value[6..8]}.#{value[9..11]}"
    end
  end

end