require 'spec_helper'

module Khipu
  describe "#configure" do

    before do
      Khipu.configure do |config|
        config.receiver_id = "33875"
        config.secret_key = "6c61f5df3c5f92cbac96b85cce32fb5b0bb04997"
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
  end
end