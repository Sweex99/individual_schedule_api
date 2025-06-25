class RequestsController < ApplicationController
  before_action :set_request, only: %i[ update update_status statement_generate ]

  def index
    @requests = params[:state] == 'all' || params[:state].nil? ? requests : Request.where(state: params[:state])

    render json: RequestsSerializer.render_as_hash(@requests, view: :with_student)
  end

  def actual
    render json: RequestsSerializer.render(current_user.requests.actual, view: :with_student)
  end

  def statement_generate
    pdf = PdfGeneratorService.new(@request).perform

    send_data pdf,
            filename: "individual_schedule_request_#{@request.id}.pdf",
            type: "application/pdf",
            disposition: "inline"
  end

  def bulk_statement_generate
    pdf = BulkPdfGeneratorService.new(Request.where(id: params[:ids].split(","))).perform

    send_data pdf,
            filename: "individual_schedule_requests.pdf",
            type: "application/pdf",
            disposition: "inline"
  end

  def requests_list_generate
    pdf = RequestsListPdfGeneratorService.new(Request.where(id: params[:ids].split(","))).perform

    send_data pdf,
            filename: "individual_schedule_requests.pdf",
            type: "application/pdf",
            disposition: "inline"
  end

  def create
    @request = current_user.requests.build(request_params)
  
    begin
      ActiveRecord::Base.transaction do
        @request.save!  # save! підіймає помилку, якщо невалідна
        @request.student.update!(student_params)
  
        Admin.find_each do |admin|
          Notification.create!(
            user_id: admin.id,
            text: "Студент #{current_user.full_name} подав запит на отримання індивідуального графіку у зв'язку з #{@request.reason.description}"
          )
        end
      end

      render json: @request, status: :created, location: @request
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end
  

  def update
    if @request.update(request_params)
      render json: @request
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  def update_status
    if @request.send(status_request_params[:status])
      Notification.create(user_id: @request.student.id, text: "Запит №#{@request.id} було підтверджено #{state_name(status_request_params[:status])}")
      render json: RequestsSerializer.render(@request, view: :with_student)
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def requests
    current_user.type == 'Admin' ? Request.all : current_user.requests
  end

  def request_params
    params.require(:request).permit(:hire_document, :reason_id, )
  end

  def student_params
    params.require(:request).require(:student).permit(:semester, :gender, :group_id)
  end

  def status_request_params
    params.permit(:status)
  end

  def state_name(status)
    if status == ""
    elsif status == ''
    elsif status == ''
    elsif status == ''
    end
  end
end
