class EmailSenderWorker
  include Sidekiq::Worker

  def perform(campaign_id, contact_data, is_test = false)
    campaign = Campaign.find(campaign_id)
    return unless campaign.can_send?(is_test)
    campaign.deliver_email!(contact_data)
  end
end
