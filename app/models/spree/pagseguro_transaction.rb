module Spree
  class PagseguroTransaction < ActiveRecord::Base
    has_many :payments, as: :source

    def actions
      []
    end

    def self.create_from_postback(params)
    end
  end
end
