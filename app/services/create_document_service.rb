class CreateDocumentService
  def self.create(params:, instance:, office:, user:)
    template = office.templates.find(params[:template_id])

    document = instance.documents.new params.merge(created_by: user)
    document.name = template.name if document.name.empty?
    document.context = instance.hashed_properties

    # get file from activestorage
    template_file = Tempfile.new
    template_file.binmode
    template_file.write(template.file.download)

    # generate doc_file from template
    doc_file = generate(context: document.context, template: template_file)
    document.file.attach(
      io: doc_file,
      filename: "#{document.name}.docx",
      content_type: 'file/docx'
    )

    # save document with the doc_file
    document.save

    document
  end

  def self.generate(context:, template:)
    sablon_template = Sablon.template(template)
    tempfile = Tempfile.new

    sablon_template.render_to_file(tempfile, context)

    tempfile
  end
end
