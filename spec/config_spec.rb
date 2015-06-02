require "spec_helper"

module Khipu
  describe Config do
    describe "#receiver_id=" do
      it "can set value" do
        config = Config.new
        config.receiver_id = "1231"
        expect(config.receiver_id).to eq("1231")
      end
    end

    describe "#secret_key=" do
      it "can set value" do
        config = Config.new
        config.secret_key = "123sadsawe3444"
        expect(config.secret_key).to eq("123sadsawe3444")
      end
    end
  end
end