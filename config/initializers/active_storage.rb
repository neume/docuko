require 'activestorage_docx_previewer'

Rails.application.config.active_storage.previewers << ActiveStorage::Previewer::DocxPreviewer
