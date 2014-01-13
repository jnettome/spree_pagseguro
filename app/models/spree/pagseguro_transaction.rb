module Spree
  class PagseguroTransaction < ActiveRecord::Base
    has_many :payments, :as => :source

    def actions
      []
    end

    def self.update_last_transaction(params)
      method = Spree::PaymentMethod.where(type: 'Spree::BillingIntegration::Pagseguro::Checkout').first

      notification_code = params[:notificationCode]
      notification = Spree::BillingIntegration::Pagseguro::Checkout.notification(method.preferred_email, method.preferred_token, notification_code)

      pagseguro_transaction = self.find_by_order_id(Spree::Order.find_by_number(notification.reference).id.to_s)
      pagseguro_transaction.params = params.to_s
      pagseguro_transaction.transaction_id = notification.transaction_id
      pagseguro_transaction.customer_id = notification_code # Todo refactor column name
      pagseguro_transaction.status = 'paid' if notification.approved?
      pagseguro_transaction.save!

      notification
    end

  end
end
