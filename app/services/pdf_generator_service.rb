require 'prawn'
require 'prawn/table'

class PdfGeneratorService
  attr_reader :student, :request

  def initialize(request)
    @student = request.student
    @request = request
  end

  def perform
    generate_individual_schedule_statement(Prawn::Document.new(page_size: 'A4')).render
  end

  def generate_individual_schedule_statement(pdf)
    font_path        = Rails.root.join('app', 'assets', 'fonts', 'DejaVuSans.ttf')
    bold_font_path   = Rails.root.join('app', 'assets', 'fonts', 'DejaVuSans-Bold.ttf')
    italic_font_path = Rails.root.join('app', 'assets', 'fonts', 'DejaVuSans-BoldOblique.ttf')

    pdf.font_families.update('DejaVu' => {
      normal: font_path,
      bold: bold_font_path,
      italic: italic_font_path
    })

    pdf.font 'DejaVu'
    pdf.font_size 14
    # 🧾 Шапка
    pdf.text request.student.group.statement_head_text, align: :right
    pdf.text "#{student_gender} #{student.semester / 2}-го курсу", align: :right
    pdf.text "спеціальності: #{student.group.description}", align: :right
    pdf.text "#{student.full_name}\n", align: :right

    # --- Сторінка 1 ---
    # Визначимо висоту для центрованого розміщення
    available_height = pdf.cursor
    content_height = 200 # умовна висота блоку основного тексту
    top_padding = (available_height - content_height) / 4

    pdf.move_down top_padding

    pdf.move_down 20

    # 📄 Назва
    pdf.text "Заява", align: :center, style: :bold

    pdf.move_down 20

    # 📝 Текст заяви
    pdf.text "Прошу надати мені індивідуальний графік навчання у #{ short_semester } семестрі #{ student.semester }-го навчального року у зв'язку з #{ request.reason.description }.", align: :center

    # 📅 Дата та підпис внизу
    pdf.move_down 100

    date_text = "#{request.created_at.strftime('%d.%m.%Y')}"
    signature_text = "Підписано!"

    date_width = pdf.width_of(date_text)
    signature_width = pdf.width_of(signature_text)

    pdf.draw_text date_text, at: [0, pdf.cursor]
    pdf.font 'DejaVu', style: :italic
    pdf.draw_text signature_text, at: [pdf.bounds.width - signature_width, pdf.cursor]
    pdf.font 'DejaVu', style: :normal

    # --- Сторінка 2: Таблиця ---
    pdf.start_new_page

    pdf.text "Індивідуальний графік навчання", align: :center, style: :bold
    pdf.move_down 20

    # Табличні дані
    data = [["Предмет", "К-ть год.", "Викладач", "Коментар", "Статус"]]
    request.subjects_teachers.each do |st|
      data << [
        st.subject.name,
        st.subject.hours_count,
        st.teacher.full_name,
        st.comment.presence || "-",
        humanize_state(st.state)
      ]
    end

    column_widths = [100, 40, 80, 230, 70] # Сума = 520 (допустимо)

    pdf.table(data, header: true, column_widths: column_widths) do
      row(0).font_style = :bold
      row(0).background_color = 'dddddd'
      self.row_colors = ['ffffff', 'f5f5f5']
      self.cell_style = {
        size: 10,
        padding: [8, 6],
        borders: [:top, :bottom],
        border_color: 'aaaaaa'
      }
    end

    pdf
  end

  private

  def student_gender
    student.male? ? 'студента' : 'студентки'
  end

  def short_semester
    student.semester % 2 == 0 ? 'другому' : 'першому'
  end

  def humanize_state(state)
    if state == "approved"
      "Підписано"
    elsif state == "pending"
      "Очікується"
    else
      "Відхилено"
    end
  end
end
