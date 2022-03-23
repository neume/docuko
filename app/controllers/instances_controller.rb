class InstancesController < ApplicationController
  layout 'office'

  def index
    @instances = if params[:search].present?
                   search_instances
                 else
                   data_model.instances.page(params[:page])
                 end
    @data_models = current_office.data_models.where.not(id: @data_model.id)
    @properties = @data_model.properties.where(header_visibility: true)
    @params = request.query_parameters
  end

  def new
    # props = data_model.properties.collect { |prop| { name: prop.code } }
    @instance = data_model.instances.new data_model_name: data_model.name
    CreateInstanceService.build_instance_properties_from_data_model @instance
    # @instance.properties.build
  end

  def create
    data = properties_params.merge(
      data_model_id: data_model.id
    )

    @instance = CreateInstanceService.create(data, data_model, current_user)

    if @instance.persisted?
      redirect_to [current_office, @instance],
                  notice: "#{data_model.name} was successfully created"
    else
      @validated = true
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @instance = current_office.instances.find(params[:id])
    @data_model = @instance.data_model
    @properties = @instance.properties.joins(:model_property).order('model_properties.position DESC')
    @documents = @instance.documents.order('documents.created_at DESC')
  end

  def edit
    @instance = current_office.instances.find(params[:id])
    @data_model = @instance.data_model
  end

  private

  def data_model
    @data_model ||= current_office.data_models.find(params[:data_model_id])
  end

  def properties_params
    params.require(:properties).permit(data_model.properties.pluck(:code))
  end

  def search_instances
    @matched_properties = data_model.instance_properties.where('lower(instance_properties.value) LIKE ?',
                                                               "%#{params[:search].downcase}%")
    data_model.instances.where(id: @matched_properties.select('instance_id').distinct).page(params[:page])
  end
end
