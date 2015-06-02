require 'spec_helper'

describe Khipu::Config do

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