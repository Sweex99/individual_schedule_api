class SamlSessionsController < Devise::SamlSessionsController
  skip_before_action :authentificate_request, only: [:new, :create]

  def new
    idp_entity_id = get_idp_entity_id(params)
    auth_request  = OneLogin::RubySaml::Authrequest.new
    auth_params   = { RelayState: relay_state } if relay_state
    action        = auth_request.create(saml_config(idp_entity_id, request), auth_params || {})

    session[:saml_transaction_id] = auth_request.request_id if auth_request.respond_to?(:request_id)

    render json: { sso_link: action }, status: 200
  end 

  def create
    super do
      redirect_to "#{ENV.fetch('FRONT_END_URL')}/login/accepted?accessToken=#{jwt_encode({user_id: warden.user.id})}", allow_other_host: true
      return
    end
  end

  def accepted
    render json: UsersSerializer.render_as_hash(current_user), status: :ok
    return
  end

end