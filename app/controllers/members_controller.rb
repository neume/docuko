class MembersController < ApplicationController
  before_action :authorize_admin!

  layout 'office'

  def new
    @member = current_office.members.new member_role: :regular
    @users = User.all.where.not(id: current_office.members.pluck(:user_id))
    respond_to do |format|
      format.js
    end
  end

  def create
    @member = current_office.members.new member_params

    respond_to do |format|
      format.js do
        if @member.save
          redirect_to [:edit, current_office], notice: 'Member added'
        else
          @users = User.all.where.not(id: current_office.members.pluck(:user_id))
          render :new
        end
      end
    end
  end

  def change_role
    @member = current_office.members.find(params[:id])
    return flash[:alert] = 'You can not change your own role' if @member.user_id == current_user.id

    flash[:notice] = 'Role updated' if @member.update member_role: params[:member_role]
  end

  private

  def member_params
    params.require(:member).permit(:user_id, :member_role)
  end
end
