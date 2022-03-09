class DocumentsController < ApplicationController
  # similar to new. Should be renamed
  def new
    @instance = current_office.instances.find(params[:instance_id])
    @templates = @instance.data_model.templates
    @document = @instance.documents.new
  end

  def create
    @instance = current_office.instances.find(params[:instance_id])
    @template = current_office.templates.find(document_params[:template_id])
    @document = @instance.documents.new document_params.merge(created_by: current_user)

    @document.name = @template.name if @document.name.empty?

    if @document.save
      redirect_to [current_office, @instance]
    end
  end

  private

  def document_params
    params.require(:document).permit(:name, :template_id, :notes)
  end
end
