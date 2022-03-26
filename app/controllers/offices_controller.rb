class OfficesController < ApplicationController
  layout 'office'

  def index
    @memberships = current_user.members.includes(:office).order("offices.#{sort_column} #{sort_direction}")
    return render :empty if @memberships.count.zero?

    if params[:search]
      @memberships = @memberships.where('lower(offices.name) LIKE ?', "%#{params[:search].downcase}%")
    end
  end

  def new
    @office = current_user.offices.new
  end

  def create
    @office = current_user.offices.new office_params.merge(created_by: current_user)
    @office.members.build(user: current_user, member_role: :admin)

    if @office.save
      redirect_to [@office, :data_models], notice: 'Office was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if current_office.data_models.count.positive?
      redirect_to [current_office, office.data_models.first, :instances]
    else
      redirect_to [:new, current_office, :data_model]
    end
  end
  # def show
  #   @current_office = office
  #   @instances = current_office.instances.order('instances.created_at DESC').page(params[:page])

  #   @data_models = current_office.data_models.page(params[:page])
  #   if @data_models.count.zero?
  #     render :empty
  #   end
  #   @params = request.query_parameters
  # end

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

  private

  def office_params
    params.require(:office).permit(:name, :slug)
  end

  def office
    @office ||= current_user.created_offices.find_by(slug: params[:slug])
  end

  def sort_column
    return params[:sort] if %w[name slug].include? params[:sort]

    'name'
  end

  def sort_direction
    params[:direction] == 'desc' ? 'DESC' : 'ASC'
  end
end
