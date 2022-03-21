class PagesController < ApplicationController
  def dashboard
    @offices = current_user.offices
    if @offices.count.positive?
      redirect_to @offices.first
    end
  end
end
