class OfficesController < ApplicationController
  def index
    @offices = current_user.offices
  end

  def new
    @office = current_user.offices.new
  end

  def create
    @office = current_user.offices.new office_params.merge(created_by: current_user)
    @office.members.build(user: current_user, member_role: :admin)

    if @office.save
      redirect_to @office, notice: 'Office was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    office
    @data_models = office.data_models
  end

  def edit
    office
  end

  def update
    office

    respond_to do |format|
      if @office.update(office_params)
        format.html { redirect_to admin_office_path(@office.slug), notice: 'Office was successfully updated.' }
        format.json { render :show, status: :ok, location: @office }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  def admin
    redirect_to [office, office.data_models.first] if office.data_models.count.positive?
  end

  private

  def office_params
    params.require(:office).permit(:name, :slug)
  end

  def office
    @office ||= current_user.created_offices.find_by(slug: params[:slug])
  end
end
