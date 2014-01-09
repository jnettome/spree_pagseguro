module Spree
  class PagseguroTransaction < ActiveRecord::Base
    def actions
      []
    end

    def self.update_last_transaction(params)
      method = Spree::PaymentMethod.where(type: 'Spree::BillingIntegration::Pagseguro::Checkout').first

      notification_code = params[:notificationCode]
      notification = ::PagSeguro::Notification.new(method.preferred_email, method.preferred_token, notification_code)

      pagseguro_transaction = self.find_by_order_id(notification.id)
      pagseguro_transaction.params = params
      pagseguro_transaction.transaction_id = notification.transaction_id
      pagseguro_transaction.customer_id = notification_code # Todo refactor column name
      pagseguro_transaction.status = 'paid' if notification.approved?
      pagseguro.save!

      notification
    end

  end
end
