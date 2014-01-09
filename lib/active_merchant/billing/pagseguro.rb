require 'pag_seguro'
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class Pagseguro < Gateway

      def service_url
        "https://pagseguro.uol.com.br"
      end

      def payment_url(options)
        redirect_url     = Rails.env.test? ? nil : "#{Spree::Config.site_url}/pagseguro/callback?order=#{options[:order_id]}"
        notification_url = Rails.env.test? ? nil : "#{Spree::Config.site_url}/pagseguro/notify"

        payment = ::PagSeguro::Payment.new(options[:email], options[:token],
        extra_amount: (options[:total] - options[:item_total]).round(2), id: options[:order_id],
        notification_url: notification_url, redirect_url: redirect_url)

        payment.items = options[:items].map do |item|
          product              = ::PagSeguro::Item.new
          product.id           = item.id
          product.description  = item.variant.name
          product.amount       = item.price.round(2)
          product.weight       = (item.variant.weight * 1000).to_i if item.variant.weight.present?
          product.quantity     = item.quantity
          product
        end

        payment.sender = ::PagSeguro::Sender.new(
          name: options[:customer_name], email: options[:customer_email],
          phone_ddd: options[:customer_ddd], phone_number: options[:customer_phone])

        payment.shipping = ::PagSeguro::Shipping.new(
          type: ::PagSeguro::Shipping::UNIDENTIFIED, state: (options[:state] ? options[:state] : nil),
          city: options[:city], postal_code: options[:postal_code], street: options[:address])

        payment
      end

      def self.notification(email, token, notification_code)
        ::PagSeguro::Notification.new(email, token, notification_code)
      end

      def self.checkout_payment_url(code)
        ::PagSeguro::Payment.checkout_payment_url(code)
      end

    end
  end
end
