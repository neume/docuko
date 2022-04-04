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

  def destroy_modal
    document
  end

  def destroy
    instance = document.instance
    document.destroy
    redirect_to [current_office, instance], notice: 'Document deleted'
  end

  private

  def document
    @document ||= current_office.documents.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:name, :template_id, :notes)
  end
end
