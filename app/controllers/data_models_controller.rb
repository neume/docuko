class DataModelsController < ApplicationController
  before_action :authorize_admin!

  def index
    @data_models = current_office.data_models.all
  end

  def new
    @data_model = current_user.created_data_models.new
  end

  def create
    @data_model = current_user.created_data_models.new data_model_params
    @data_model.office = current_office
    if data_model.save
      redirect_to [current_office, @data_model]
    else
      render :new
    end
  end

  def edit
    data_model
  end

  def update
    if data_model.update(data_model_params)
      redirect_to [current_office, data_model]
    else
      render :new
    end
  end

  def show
    data_model
    @model_properties = data_model.properties.order('model_properties.position ASC')
    @templates = data_model.templates.order('templates.name ASC')
  end

  private

  def data_model
    @data_model ||= DataModel.find(params[:id])
  end

  def data_model_params
    params.require(:data_model).permit(:name)
  end
end
