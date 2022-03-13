class RegistrationsController < Devise::RegistrationsController
  def destroy
    redirect_to root_path, alert: 'This action is not allowed at the moment'
  end
end
