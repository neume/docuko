class DocumentsController < ApplicationController
  # similar to new. Should be renamed
  def new
    @instance = current_office.instances.find(params[:instance_id])
    @templates = @instance.data_model.templates
    @document = @instance.documents.new
  end

  def create
    @instance = current_office.instances.find(params[:instance_id])
    options = {
      params: document_params,
      instance: @instance,
      office: current_office,
      user: current_user
    }

    @document = CreateDocumentService.create(**options)
    redirect_to [current_office, @instance]
  end

  private

  def document_params
    params.require(:document).permit(:name, :template_id, :notes)
  end
end
