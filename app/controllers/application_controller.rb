# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authenticable
  
  before_action :authenticate_user, :current_account, unless: :devise_controller?
end
