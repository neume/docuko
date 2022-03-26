class SearchUsersController < ApplicationController
  respond_to :json

  def index
    @users = User.all
                 .where.not(id: current_office.users.select(:id))
                 .limit(10)

    if params[:search]
      @users = @users.where('lower(users.email) LIKE ?', "%#{params[:search].downcase}%")
    end
  end
end
