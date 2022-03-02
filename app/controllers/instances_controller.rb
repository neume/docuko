class InstancesController < ApplicationController
  def index
    @instances = Instance.where(data_model_id: data_model.id)
    @properties = @data_model.properties.where(header_visibility: true)
  end

  def new
    props = data_model.properties.collect { |prop| { field_name: prop.code } }
    @instance = Instance.new data_model_name: data_model.name
    @instance.properties.build props
  end

  def create
    data = properties_params.merge(
      data_model_id: data_model.id
    )

    @instance = CreateInstanceService.create(data, data_model)

    if @instance.persisted?
      redirect_to office_instance_path(@instance.id, office_slug: current_office.slug),
                  notice: "#{data_model.name} was successfully created"
    else
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

  # TODO
  # def update
  # end

  private

  def data_model
    @data_model ||= current_office.data_models.find(params[:data_model_id])
  end

  def properties_params
    params.require(:properties).permit(data_model.properties.pluck(:code))
  end
end
