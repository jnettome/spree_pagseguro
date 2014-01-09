module Spree
  class PagseguroController < Spree::StoreController
    def callback
      @order = Spree::Order.find_by_number(params[:order])

      pagseguro_transaction = Spree::PagseguroTransaction.find_by_order_id(@order.id.to_s)
      pagseguro_transaction.update_attribute :status, 'waiting'

      redirect_to spree.order_path(@order)
    end

    def notify
      notification = Spree::PagseguroTransaction.update_last_transaction(params)
      payment_method = Spree::PaymentMethod.where(type: 'Spree::BillingIntegration::Pagseguro::Checkout').first

      @order = Spree::Order.find(notification.id)
      payment = @order.payments.where(:state => "pending",
                                      :payment_method_id => payment_method.id).last

      if notification.approved?
        payment.complete!
      else
        payment.failure!
      end

      render nothing: true, head: :ok
    end

  end
end
