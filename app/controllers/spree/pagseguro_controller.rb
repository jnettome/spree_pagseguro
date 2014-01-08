module Spree
  class PagseguroController < ApplicationController
    def callback
      render text: 'thank you'
    end

    def notify
      notification = Spree::PaymentNotification.create_from_params(params)

      if notification.approved?
        Order.transaction do
          @order = Spree::Order.find(notification.id)
          @order.payment.complete
        end
      end

      render nothing: true, head: :ok
    end

  end
end
