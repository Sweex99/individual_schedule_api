class ApplicationController < ActionController::API
  include JwtWebToken

  before_action :authentificate_request

  private

  def authentificate_request
    if (header = request.headers['Authorization'])
      token = header.split(' ').last

      begin
        decoded_token = JWT.decode(token, SECRET_KEY)
        @current_user = User.find(decoded_token[0]['user_id'])
      rescue JWT::ExpiredSignature
        render json: { error: 'Сесія завершена. Будь ласка, увійдіть повторно.' }, status: :unauthorized
      rescue JWT::DecodeError
        render json: { error: 'Невалідний токен авторизації.' }, status: :unauthorized
      end
    else
      render json: { error: 'Токен авторизації відсутній.' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
