class Accounts::SessionsController < Devise::SessionsController
  # Tell warden that params authentication is allowed for that specific page
  prepend_before_action :allow_params_authentication!, only: :create

  # Login Method
  def create
    resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render json: {
      id: resource.id,
      auth_token: resource.auth_token
    }
  end
end
