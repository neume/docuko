class MembersController < ApplicationController
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

  private

  def member_params
    params.require(:member).permit(:user_id, :member_role)
  end
end
