class PagesController < ApplicationController
  def dashboard
    @offices = current_user.offices
  end
end
