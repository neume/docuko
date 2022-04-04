class TemplatesController < ApplicationController
  before_action :authorize_admin!
  before_action :set_template, only: %i[show edit update]
  layout 'office'

  # GET /templates/1 or /templates/1.json
  def show; end

  # GET /templates/new
  def new
    @template = data_model.templates.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /templates/1/edit
  def edit; end

  # POST /templates or /templates.json
  def create
    @template = data_model.templates.new(template_params)

    respond_to do |format|
      if @template.save
        format.html { redirect_to [current_office, data_model], notice: 'Template was successfully created.' }
        format.js { flash[:notice] = 'Template was successfully created' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /templates/1 or /templates/1.json
  def update
    @data_model = @template.data_model
    if @template.update(template_params)
      redirect_to [current_office, data_model], notice: 'Template was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy_modal
    set_template
  end

  def destroy
    set_template

    data_model = @template.data_model

    @template.destroy
    redirect_to [current_office, data_model], notice: 'Field deleted'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_template
    @template = current_office.templates.find(params[:id])
  end

  def data_model
    @data_model ||= current_office.data_models.find(params[:data_model_id])
  end

  # Only allow a list of trusted parameters through.
  def template_params
    params.require(:template).permit(:name, :file, :description)
  end
end
