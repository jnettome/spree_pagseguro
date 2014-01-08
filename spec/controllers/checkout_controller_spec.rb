require 'spec_helper'

describe Spree::CheckoutController do
  let(:pagseguro_gateway) { BillingIntegration::Pagseguro::Checkout.new :id => 123 }
  let(:order) { create(:order_with_line_items, :state => "payment") }

  before do
    controller.stub(:current_order => order, :check_authorization => true, :current_user => order.user)
    order.stub(:checkout_allowed? => true, :completed? => false)
    order.update!
  end

end
