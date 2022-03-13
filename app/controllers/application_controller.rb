class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_user
  helper_method :current_office

  private

  # def current_user
  #   @current_user ||= User.first
  # end

  def current_office
    @current_office ||= current_user.offices.find_by(slug: (params[:office_slug] || params[:slug]))
  end
end
