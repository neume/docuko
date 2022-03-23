class PagesController < ApplicationController
  def dashboard
    @offices = current_user.offices
    if @offices.count.positive?
      office = @offices.first
      if office.data_models.count.positive?
        redirect_to [office, office.data_models.first, :instances]
      else
        redirect_to [:new, @offices.first, :data_model]
      end
    end
  end
end
