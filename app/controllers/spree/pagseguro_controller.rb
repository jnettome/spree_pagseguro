module Spree
  class PagseguroController < ApplicationController
    def callback
      order = Spree::Order.find_by_number(params[:order])

      pagseguro_transaction = PagseguroTransaction.find_by_order_id(order.id.to_s)
      pagseguro_transaction.update_attribute :status, 'waiting'

      redirect_to order_path(id: params[:order])
    end

    def notify
      notification = Spree::PaymentNotification.update_last_transaction(params)

      if notification.approved?
        Spree::Order.transaction do
          @order = Spree::Order.find(notification.id)
          @order.payment.complete!
        end
      else
        Spree::Order.transaction do
          @order = Spree::Order.find(notification.id)
          @order.payment.failure!
        end
      end

      render nothing: true, head: :ok
    end

  end
end
