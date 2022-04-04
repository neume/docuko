class ModelPropertiesController < ApplicationController
  before_action :authorize_admin!

  layout 'office'

  def new
    @model_property = data_model.properties.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @model_property = data_model.properties.new property_params
    respond_to do |format|
      format.html do
        if model_property.save
          redirect_to [current_office, data_model], notice: 'Property created'
        else
          render :new, status: :unprocessable_entity
        end
      end
      format.js { model_property.save }
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
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy_modal
    model_property
  end

  def destroy
    data_model = model_property.data_model
    model_property.destroy
    redirect_to [current_office, data_model], notice: 'Field deleted'
  end

  private

  def data_model
    @data_model ||= DataModel.find(params[:data_model_id])
  end

  def model_property
    @model_property ||= current_office.model_properties.find(params[:id])
  end

  def property_params
    params.require(:model_property).permit(:name, :required, :code, :header_visibility, :description, :position,
                                           :default_value)
  end
end
