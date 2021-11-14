module Authenticable
  def authenticate_user
    if @current_account.nil?
      render json: { errors: [{message: 'This user is unauthenticated'}] },
             status: :unauthorized unless current_account.present?
    end
  end

  def current_account
    @current_account ||= Account.find_by(auth_token: request.headers['Authorization'])
    @current_account
  end
end
