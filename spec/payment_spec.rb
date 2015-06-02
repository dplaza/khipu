require "spec_helper"

module Khipu
  describe Payment do

    before do
      Khipu.configure do |config|
        config.receiver_id = "33875"
        config.secret_key = "6c61f5df3c5f92cbac96b85cce32fb5b0bb04997"
      end
    end

    describe "#redirect_url" do
      it "can get redirect url" do
        payment = Payment.new subject: "Test", amount: "1990"
        expect(payment.redirect_url).to include("khipu.com/payment/show/")
      end
    end
  end
end