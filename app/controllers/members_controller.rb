class MembersController < ApplicationController
  before_action :authorize_admin!

  def index
    @members = current_office.members
  end

  # TODO: use proper searching on select tag
  def new
    @member = current_office.members.new member_role: :regular
    @users = User.all.where.not(id: current_office.members.pluck(:user_id))
  end

  def create
    @member = current_office.members.new member_params

    if @member.save
      redirect_to [current_office, :members], notice: 'Member added'
    else
      @users = User.all.where.not(id: current_office.members.pluck(:user_id))
      render :new
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
