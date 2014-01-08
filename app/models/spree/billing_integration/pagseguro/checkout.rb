module Spree
  class BillingIntegration::Pagseguro::Checkout < BillingIntegration
    preference :email, :string
    preference :token, :string

    def provider_class
      ActiveMerchant::Billing::Pagseguro
    end

    def redirect_url(order, options = {})
      options.merge! self.preferences

      options[:customer_name] = [order.bill_address.firstname, order.bill_address.lastname].join(' ')
      options[:customer_email] = order.email
      options[:customer_ddd] = order.bill_address.phone.gsub(/\D/,'')[0..1] if order.bill_address.phone
      options[:customer_phone] = order.bill_address.phone.gsub(/\D/,'') if order.bill_address.phone

      options[:address] = [order.bill_address.address1, order.bill_address.address2].join(' ')
      options[:city] = order.bill_address.city
      options[:postal_code] = order.bill_address.zipcode
      options[:state] = order.bill_address.state.nil? ? order.bill_address.state_name.to_s : order.bill_address.state.abbr
      options[:country] = order.bill_address.country.name

      options[:total] = order.total
      options[:item_total] = order.item_total
      options[:items] = order.line_items

      options[:order_id] = order.number

      options[:email] = (Rails.env.development? || Rails.env.test?) ? ENV['SPREE_PAGSEGURO_EMAIL'] : preferences[:email]
      options[:token] = (Rails.env.development? || Rails.env.test?) ? ENV['SPREE_PAGSEGURO_TOKEN'] : preferences[:token]

      pagseguro = self.provider.payment_url(options)

      transaction = PagseguroTransaction.create(code: pagseguro.code)
      pagseguro.checkout_payment_url
    end
  end
end
