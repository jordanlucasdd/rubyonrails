class BasePresenter
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::AssetUrlHelper

  def self.wrap list
    list.map { |item| new(item) }
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end

  def render(partial:, locals:)
    ActionView::Base.new(Rails.configuration.paths['app/views']).render partial: partial, locals: locals
  end

  def asset(file)
    ActionController::Base.helpers.asset_path(file)
  end

  
end