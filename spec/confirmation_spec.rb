require "spec_helper"

module Khipu
  describe Confirmation do

    before do
      Khipu.configure do |config|
        config.receiver_id = "1234412"
        config.secret_key = "1234412asdasf3243rwfdsafcas22"
      end
    end

    describe "#initialize" do
      it "should be fail without required params" do
        confirmation = Confirmation.new
        expect(confirmation).to raise_error(ArgumentError)
      end
    end
  end
end