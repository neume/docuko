class PagesController < ApplicationController
  def dashboard
    @offices = current_user.created_offices
  end
end
