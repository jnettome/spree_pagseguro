module Spree
  CheckoutController.class_eval do
    before_filter :confirm_pagseguro, :only => [:update]

    private
    # This method hacks order update event to generate a payment transaction
    # using pagseguro and displays payment button
    def confirm_pagseguro
      return unless (params[:state] == "payment") && params[:order][:payments_attributes]

      payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
      if payment_method.kind_of?(BillingIntegration::Pagseguro::Checkout)
        @order.payments.create(:amount => @order.total, :payment_method_id => payment_method.id)
        redirect_to payment_method.redirect_url(@order)
      end
    end

  end
end
