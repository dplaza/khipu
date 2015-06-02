require "spec_helper"

module Khipu
  describe Confirmation do

    before do
      Khipu.configure do |config|
        config.receiver_id = "33875"
        config.secret_key = "6c61f5df3c5f92cbac96b85cce32fb5b0bb04997"
      end
    end

    describe "#initialize" do
      it "should be fail without required params" do
        confirmation = Confirmation.new
        expect(confirmation).to raise_error(ArgumentError)
      end
    end

    describe "#initialize" do
      it "should be receive a response" do
        json = { "api_version" => "1.3", "notification_token" => "9935b5e051a87d4214d987c9e51660bf23589908903e50f08aceb15c62eeb61c" }.to_json
        confirmation = Confirmation.new body: json

        expect(confirmation.transaction_id).to eq("133")
      end
    end
  end
end