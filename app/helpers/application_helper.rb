module ApplicationHelper

  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :success
      "alert-success"
    when :danger
      "alert-danger"
    when :warning
      "alert-warning"
    when :notice
      "alert-primary"
    else
      flash_type.to_s
    end
  end
  
end
