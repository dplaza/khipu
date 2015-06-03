module Khipu
  class Payment
    attr_accessor :receiver_id
    attr_accessor :subject
    attr_accessor :body
    attr_accessor :amount
    attr_accessor :notify_url
    attr_accessor :return_url
    attr_accessor :cancel_url
    attr_accessor :custom
    attr_accessor :transaction_id
    attr_accessor :payer_email
    attr_accessor :expires_date
    attr_accessor :bank_id
    attr_accessor :picture_url

    def initialize(options = {})
      self.receiver_id = options[:receiver_id] || Khipu.config.receiver_id
      self.subject = options[:subject]
      self.body = options[:body]
      self.amount = options[:amount]
      self.notify_url = options[:notify_url]
      self.return_url = options[:return_url]
      self.cancel_url = options[:cancel_url]
      self.custom = options[:custom]
      self.transaction_id = options[:transaction_id]
      self.payer_email = options[:payer_email]
      self.expires_date = options[:expires_date]
      self.bank_id = options[:bank_id]
      self.picture_url = options[:picture_url]
    end

    def redirect_url
      verify!
      create_payment_url
    end

    private

    def verify!
      raise ArgumentError, "Receiver ID required" if self.receiver_id.nil?    
      raise ArgumentError, "Subject required" if self.subject.nil?
      raise ArgumentError, "Amount required" if self.amount.nil?
    end

    def generate_hash
      message = "receiver_id=#{receiver_id}&subject=#{subject}&body=#{body}&amount=#{amount}&payer_email=#{payer_email}&bank_id=#{bank_id}&expires_date=#{expires_date}&transaction_id=#{transaction_id}&custom=#{custom}&notify_url=#{notify_url}&return_url=#{return_url}&cancel_url=#{cancel_url}&picture_url=#{picture_url}"
      OpenSSL::HMAC.hexdigest 'sha256', Khipu.config.secret_key, message
    end

    def create_payment_url
      url = 'https://khipu.com/api/1.3/createPaymentURL'
      uri = URI.parse(url)

      response = Net::HTTP.post_form(uri, {
          "receiver_id" => receiver_id,
          "subject" => subject,
          "body" => body,
          "amount" => amount,
          "notify_url" => notify_url,
          "return_url" => return_url,
          "cancel_url" => cancel_url,
          "custom" => custom,
          "transaction_id" => transaction_id,
          "payer_email" => payer_email,
          "expires_date" => expires_date,
          "bank_id" => bank_id,
          "picture_url" => picture_url,
          "hash" => generate_hash
        })

      JSON.parse(response.body)["manual-url"]
    end
  end
end