# class SessionsController < ApplicationController
#   def create
#     binding.pry
#     user = Account.find_by(email: params["user"]["email"]).try(:authenticate, params["user"]["password"])
#     user = Account.find_by(email: params["email"]).try(:authenticate, params["password"])
#     user = Account.find_by(email: params[:email]).try(:authenticate, params[:password])
#
#   end
#
#   def destroy
#   end
# end

class Accounts::SessionsController < Devise::SessionsController
  # skip_before_action :verify_authenticity_token, only: [:new]

  # Tell warden that params authentication is allowed for that specific page
  prepend_before_action :allow_params_authentication!, only: :create

  # Login Method
  def create
    # User.where(confirmed_at: nil).each{|u| u.update_column(:confirmed_at, DateTime.now)}
    # binding.pry
    # request.params[:user].merge!(params[:user])
    # request.params[:user].merge!(params[:account])
    # resource = warden.authenticate!(scope: :account)
    resource = warden.authenticate!(auth_options)
    # resource = warden.authenticate!(scope: :account)
    # self.resource.set_auth_token if self.resource.present?
    sign_in(resource_name, resource)
    render json: {
      id: resource.id,
      auth_token: resource.auth_token
    }
  end
end
