require 'prawn'
require 'prawn/table'

class BulkPdfGeneratorService
  attr_reader :requests, :pdf_object

  def initialize(requests)
    @requests   = requests
  end

  def perform
    generate_individual_schedule_statement.render
  end

  def generate_individual_schedule_statement
    combined_pdf = Prawn::Document.new(page_size: 'A4')

    requests.each_with_index do |request, index|
      pdf = PdfGeneratorService.new(request).generate_individual_schedule_statement(combined_pdf)

      combined_pdf = pdf

      # Не обов'язково створювати нову сторінку, якщо generate_individual_schedule_statement вже додає нову
      combined_pdf.start_new_page
    end
  
    combined_pdf
  end
end
