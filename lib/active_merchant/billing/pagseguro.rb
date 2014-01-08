require 'pag_seguro'
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class Pagseguro < Gateway

      def service_url
        "https://www.pagseguro.com.br"
      end

      def request_payment(options)
        redirect_url     = Rails.env.development? ? nil : "#{Spree::Config.site_url}/pagseguro/callback"
        notification_url = Rails.env.development? ? nil : "#{Spree::Config.site_url}/pagseguro/notify"

        payment = ::PagSeguro::Payment.new(options[:email], options[:token],
        extra_amount: format("%.2f", (options[:total] - options[:item_total]).round(2)), id: options[:order_id],
        notification_url: notification_url, redirect_url: redirect_url)

        payment.items = options[:items].map do |item|
          item              = ::PagSeguro::Item.new
          item.id           = item.id
          item.description  = item.product.name
          item.amount       = format("%.2f", item.price.round(2))
          item.weight       = (item.product.weight * 1000).to_i if item.product.weight.present?
          item.quantity = item.quantity
          item
        end

        payment.sender = ::PagSeguro::Sender.new(
          name: options[:customer_name], email: options[:customer_email],
          phone_ddd: options[:customer_ddd], phone_number: options[:customer_phone])

        payment.shipping = ::PagSeguro::Shipping.new(
          type: ::PagSeguro::Shipping::UNIDENTIFIED, state: (options[:state] ? options[:state] : nil),
          city: options[:city], postal_code: options[:postal_code], street: options[:address])

        payment
      end

    end
  end
end
