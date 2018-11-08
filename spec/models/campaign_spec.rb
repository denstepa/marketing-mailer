require 'rails_helper'

RSpec.describe Campaign, type: :model do

  describe '.contacts' do
    context 'when file is precent' do
      context 'when file has a valid data structure' do
        let(:campaign) { FactoryBot.create(:campaign) }
        it { expect(campaign.contacts.count).to eq(2) }
        it { expect(campaign.contacts.first['email']).to eq('test@test.com') }
      end

      context 'when file has a wrong file structure' do
        let(:file) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'wrong_contacts.csv')) }
        let(:campaign) { FactoryBot.create(:campaign, contacts_file: file) }
        it { expect(campaign.contacts.count).to eq(2) }
        it { expect(campaign.contacts.first['email']).to eq(nil) }
      end
    end
  end

  describe '.schedule' do
    let(:campaign) { FactoryBot.create(:campaign, send_at: 1.hour.from_now) }
    let(:contacts) do
      [{ email: 'test@test.com', name: 'user 1' }, { email: 'test2@test.com', name: 'user 2' }]
    end
    before do
      allow(campaign).to receive(:contacts).and_return(contacts)
      campaign.schedule
    end
    it 'has enqueued sidekiq jobs' do
      contacts.each do |contact|
        expect(EmailSenderWorker).to have_enqueued_sidekiq_job(campaign.id, 'email' => contact[:email], 'name' => contact[:name]).in(1.hour)
      end
    end
  end

end
