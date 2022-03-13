class ModelPropertiesController < ApplicationController
  before_action :authorize_admin!

  def index
    redirect_back fallback_location: [current_office, data_model]
  end

  def new
    @model_property = data_model.properties.new
  end

  def create
    @model_property = data_model.properties.new property_params
    if model_property.save
      redirect_to [current_office, data_model], notice: 'Property created'
    else
      render :new
    end
  end

  def edit
    model_property
  end

  def update
    if model_property.update(property_params)
      data_model = model_property.data_model

      redirect_to [current_office, data_model], notice: 'Property updated'
    else
      render :new
    end
  end

  private

  def data_model
    @data_model ||= DataModel.find(params[:data_model_id])
  end

  def model_property
    @model_property ||= current_office.model_properties.find(params[:id])
  end

  def property_params
    params.require(:model_property).permit(:name, :required, :code, :header_visibility, :description, :position)
  end
end
