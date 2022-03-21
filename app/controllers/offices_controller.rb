class OfficesController < ApplicationController
  layout 'office'
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
      redirect_to [:edit, @office], notice: 'Office was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @current_office = office

    @data_models = current_office.data_models.page(params[:page])
    if @data_models.count.zero?
      return redirect_to [:new, current_office, :data_model], notice: 'Create your first Data Model here'
    end

    if params[:search].present?
      @data_models = @data_models.where('lower(name) LIKE ?', "%#{params[:search].downcase}%")
    end
    @params = request.query_parameters
  end

  def edit
    @current_office = office
    authorize_admin!
    office
  end

  def update
    @current_office = office
    authorize_admin!

    if current_office.update(office_params)
      redirect_to [:edit, current_office], notice: 'Office was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def admin
    @current_office = office
    @data_models = current_office.data_models
    authorize_admin!
    redirect_to [current_office, current_office.data_models.first] if current_office.data_models.count.positive?
  end

  private

  def office_params
    params.require(:office).permit(:name, :slug)
  end

  def office
    @office ||= current_user.created_offices.find_by(slug: params[:slug])
  end
end
