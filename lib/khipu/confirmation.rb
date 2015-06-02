module Khipu
  class Confirmation
    attr_accessor :receiver_id
    attr_accessor :api_version
    attr_accessor :notification_token
    attr_accessor :subject
    attr_accessor :amount
    attr_accessor :custom
    attr_accessor :transaction_id
    attr_accessor :payment_id
    attr_accessor :currency
    attr_accessor :payer_email

    def initialize(options = {})
      body = options[:body]
      self.receiver_id = body[:receiver_id] || Khipu.config.receiver_id
      self.api_version = body[:api_version] if body[:api_version]
      self.notification_token = body[:notification_token] if body[:notification_token]

      verify!
      get_payment_notification
    end

    private

    def verify!
      raise ArgumentError, "Notification Token required" if self.notification_token.nil?    
      raise ArgumentError, "API version required" if self.api_version.nil?
      raise ArgumentError, "API version not supported. Only v1.3 or higher" unless self.api_version == '1.3'
    end

    def generate_hash
      message = "receiver_id=#{receiver_id}&notification_token=#{notification_token}"
      OpenSSL::HMAC.hexdigest 'sha256', Khipu.config.secret_key, message
    end

    def get_payment_notification
      url = 'https://khipu.com/api/1.3/getPaymentNotification'
      uri = URI.parse(url)

      response = Net::HTTP.post_form(uri, {
          "receiver_id" => receiver_id,
          "notification_token" => notification_token,
          "hash" => generate_hash
        })

      json_response = JSON.parse(response.body)

      unless json_response["receiver_id"] == receiver_id.to_i
        raise "Receiver ID not applicable"
      else
        self.subject = json_response["subject"]
        self.amount = json_response["amount"].to_i
        self.custom = json_response["custom"]
        self.transaction_id = json_response["transaction_id"].to_i
        self.payment_id = json_response["payment_id"].to_i
        self.currency = json_response["currency"]
        self.payer_email = json_response["payer_email"]
      end
    end

  end
end