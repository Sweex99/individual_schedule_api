require 'prawn'
require 'prawn/table'

class RequestsListPdfGeneratorService
 def initialize(requests)
    @requests = requests
  end

  def perform
    Prawn::Document.new do |pdf|
      font_path        = Rails.root.join('app', 'assets', 'fonts', 'DejaVuSans.ttf')
      bold_font_path   = Rails.root.join('app', 'assets', 'fonts', 'DejaVuSans-Bold.ttf')
      italic_font_path = Rails.root.join('app', 'assets', 'fonts', 'DejaVuSans-BoldOblique.ttf')

      pdf.font_families.update('DejaVu' => {
        normal: font_path,
        bold: bold_font_path,
        italic: italic_font_path
      })

      pdf.font 'DejaVu'
      pdf.font_size 12
      pdf.text 'Список запитів', size: 18, style: :bold, align: :center
      pdf.move_down 15

      table_data = [['ID', 'Студент', 'Група', 'Причина', 'Дата подачі']]

      @requests.each do |request|
        student_name = "#{request.student.first_name} #{request.student.last_name}"
        table_data << [
          "##{request.id.to_s}42353425234",
          student_name,
          request.student.group.title,
          request.reason.title,
          request.created_at.strftime("%d.%m.%Y %H:%M")
        ]
      end

      pdf.table(table_data, header: true, row_colors: ["F0F0F0", "FFFFFF"], cell_style: { inline_format: true }) do
        row(0).font_style = :bold
        self.header = true
        self.column_widths = [50, 150, 50, 150, 120]
      end
    end.render
  end
end
