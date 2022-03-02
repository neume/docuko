class OfficesController < ApplicationController
  def index
    @offices = current_user.created_offices
  end

  def new
    @office = current_user.created_offices.new
  end

  def create
    @office = current_user.created_offices.new office_params

    if @office.save
      format.html { redirect_to @office, notice: 'Office was successfully created.' }
      format.json { render :show, status: :created, location: @office }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @office.errors, status: :unprocessable_entity }
    end
  end

  def show
    office
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
    office
  end

  private

  def office_params
    params.require(:office).permit(:name, :slug)
  end

  def office
    @office ||= current_user.created_offices.find_by(slug: params[:slug])
  end
end
