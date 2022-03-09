class TemplatesController < ApplicationController
  before_action :set_template, only: %i[show edit update]

  # GET /templates/1 or /templates/1.json
  def show; end

  # GET /templates/new
  def new
    @template = data_model.templates.new
  end

  # GET /templates/1/edit
  def edit; end

  # POST /templates or /templates.json
  def create
    @template = data_model.templates.new(template_params)

    respond_to do |format|
      if @template.save
        format.html { redirect_to [current_office, data_model], notice: 'Template was successfully created.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1 or /templates/1.json
  def update
    respond_to do |format|
      @data_model = @template.data_model
      if @template.update(template_params)
        format.html { redirect_to [current_office, data_model], notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
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
