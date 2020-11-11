class FormPresenter < BasePresenter

  def initialize(model=nil)
    @model = model
  end

  def value(field)
    @model[field]
  end

  def required
    raw "required data-required-error='campo obrigatório' "
  end

  def required_conditional(conditional)
    raw "required data-required-error='campo obrigatório' " if conditional
  end


  def required_message
    raw "data-required-error='campo obrigatório' "
  end

  def field_error(errors,field)
    raw "<div class='help-block with-errors text-danger'>#{errors[field].first}</div>" if errors
  end

  def error_message(input_id: nil)
    raw "<div data-input='#{input_id}' class='help-block with-errors'></div>"
  end

  def options_for_select(collection,id_selected)
    html = ""

    collection.each do |obj|
      selected = (obj.id == id_selected) ? 'selected' : ''
      html << "<option #{selected} value='#{obj.id}'>#{obj.name || obj.description }</option>"
    end

    raw(html)
  end

  def is_selected(id_option,id_selected)
    selected = (id_option == id_selected) ? 'selected' : ''

    selected
  end

  def is_checked(id_option,id_selected)

    if id_option.class == Array 
      selected = 'checked' if id_option.include?(id_selected)
    else
      selected = (id_option == id_selected) ? 'checked' : ''
    end

    selected
  end

end