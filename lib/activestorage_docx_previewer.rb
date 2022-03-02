# From zealot128
# https://gist.github.com/zealot128/5534cb70a06dcce96dba1fea7274fae5
#
# lib/activestorage_docx_previewer

module ActiveStorage
  class Previewer::DocxPreviewer < Previewer
    class << self
      # also would be supported by unoconv
      # "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      # "application/msword", "application/vnd.ms-powerpoint",
      # "application/vnd.oasis.opendocument.text",
      # "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      def accept?(blob)
        blob.content_type == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      end
    end

    def preview(**options)
      download_blob_to_tempfile do |input|
        draw_first_page_from input do |output|
          yield io: output, filename: "#{blob.filename.base}.png", content_type: 'image/png'
        end
      end
    end

    private

      def draw_first_page_from(file, &block)
        draw 'unoconv', '-f', 'pdf', '-e', 'PageRange=1', '--stdout', file.path do |output_pdf|
          make_image_from_pdf(output_pdf, &block) if File.size(output_pdf) > 0
        end
      end

      def make_image_from_pdf(output_pdf, &block)
        previewer = Rails.application.config.active_storage.previewers.find { |i|
          i.accept?(OpenStruct.new(content_type: 'application/pdf'))
        }
        previewer.new(blob).send(:draw_first_page_from, output_pdf, &block)
      end
  end
end
