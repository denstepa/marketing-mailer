class SendgridSender
  class << self
    def deliver!(mail)
      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
      sg.client.mail._('send').post(request_body: mail.to_json)
    end

  end
end