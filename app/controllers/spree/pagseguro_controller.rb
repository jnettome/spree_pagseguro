module Spree
  class PagseguroController < ApplicationController
    def callback
      @order = Spree::Order.find_by_number(params[:order])

      pagseguro_transaction = PagseguroTransaction.find_by_order_id(order.id.to_s)
      pagseguro_transaction.update_attribute :status, 'waiting'

      redirect_to completion_route
    end

    def notify
      notification = Spree::PagseguroTransaction.update_last_transaction(params)
      @order = Spree::Order.find(notification.id)

      if notification.approved?
        @order.payment.complete!
      else
        @order.payment.failure!
      end

      render nothing: true, head: :ok
    end

  end
end
