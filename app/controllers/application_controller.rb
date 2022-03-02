class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_office

  private

  def current_user
    @current_user ||= User.first
  end

  def current_office
    @current_office ||= Office.find_by(slug: (params[:office_slug] || params[:slug]))
  end
end
