require 'spec_helper'

describe Spree::BillingIntegration::Pagseguro::Checkout do
  context "redirect_url" do
    let(:payment_method) { create(:pagseguro_checkout) }
    let(:order) { create(:order_with_line_items) }

    # TODO Test with invalid credentials
    # expect {
    #   payment_method.redirect_url(order)
    # }.to raise_error(PagSeguro::Errors::Unauthorized, "Credentials provided (e-mail and token) failed to authenticate")

    it "should return checkout url given valid credentials (see README)" do
      expect { payment_method.redirect_url(order) }.not_to raise_error
      expect(payment_method.redirect_url(order)).to start_with('https://pagseguro.uol.com.br/v2')
    end
  end

end
