require 'spec_helper'

module Khipu
  describe "#configure" do

    before do
      Khipu.configure do |config|
        config.receiver_id = "1234412"
      end
    end

    it "should inject configuration methods on base module" do

      expect(Khipu).to respond_to :configure
      expect(Khipu).to respond_to :config
      expect(Khipu.config).to be_kind_of Khipu::Config

      Khipu.configure do |config|
        expect(config).to be_kind_of Khipu::Config
        expect(config).to be == Khipu.config
      end
    end

    it "should be get receiver_id" do
      expect(Khipu.config.receiver_id).to eq("1234412")
    end
  end
end