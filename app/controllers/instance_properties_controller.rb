class InstancePropertiesController < ApplicationController
  def edit
    @instance_property = current_office.instance_properties.find(params[:id])
  end

  def update
    @instance_property = current_office.instance_properties.find(params[:id])
    @instance_property.update instance_property_params
  end

  private

  def instance_property_params
    params.require(:instance_property).permit(:value)
  end
end
