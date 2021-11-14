class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show]
  before_action :set_receiver, only: [:create]

  # GET /transactions
  def index
    @transactions = Transaction.for_account(@current_account)

    render json: @transactions
  end

  # GET /transactions/sent_transactions
  def sent_transactions
    @transactions = @current_account.sent_transactions

    render json: @transactions
  end

  # GET /transactions/received_transactions
  def received_transactions
    @transactions = @current_account.received_transactions

    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.for_account(@current_account).find(params[:id])
    end

    # This method to set receiver_id in case sending receiver_phone insead of receiver_id
    def set_receiver
      if params[:transaction].present?
        return if params[:transaction][:receiver_id].present?
        if params[:transaction][:receiver]
          receiver = nil
          if params[:transaction][:receiver][:email].present?
            receiver = Account.find_by(email: params[:transaction][:receiver][:email])
          end

          if params[:transaction][:receiver][:phone_number].present?
            receiver ||= Account.find_by(phone_number: params[:transaction][:receiver][:phone_number])
          end

          params[:transaction][:receiver_id] ||= receiver.try(:id)
        end
      end
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.require(:transaction).permit(:receiver_id, :amount, :currency).merge!({sender_id: @current_account.id})
    end
end
