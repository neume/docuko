class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_user
  helper_method :current_office
  helper_method :current_membership

  private

  # def current_user
  #   @current_user ||= User.first
  # end

  def current_office
    @current_office ||= current_user.offices.find_by(slug: (params[:office_slug] || params[:slug]))
  end

  def current_membership
    @current_membership || current_office.members.find_by(user_id: current_user.id)
  end

  def authorize_admin!
    return true if current_membership&.admin?

    redirect_to root_path, alert: 'You are not allowed to access this page'
  end
end
