require 'spec_helper'

describe Spree::BillingIntegration::Pagseguro::Checkout do
  context "redirect_url" do
    let(:payment_method) { create(:pagseguro_checkout) }
    let(:order) { create(:order) }

    it "should not return url given invalid credentials" do
      expect {
        payment_method.redirect_url(order)
      }.to raise_error(PagSeguro::Errors::Unauthorized, "Credentials provided (e-mail and token) failed to authenticate")
    end
  end

end
