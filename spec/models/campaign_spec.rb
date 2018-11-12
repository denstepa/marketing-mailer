require 'rails_helper'

RSpec.describe Campaign, type: :model do

  describe '.update' do
    let(:campaign) { FactoryBot.create(:campaign, contacts_file: nil) }
    let(:file) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'test_contacts.csv')) }
    it 'counts contacts on save' do
      expect(campaign).to receive(:count_contacts)
      campaign.update(contacts_file: file)
    end
  end

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

  describe '.test_contacts' do
    context 'when file is precent' do
      context 'when file has a valid data structure' do
        let(:file) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'test_contacts.csv')) }
        let(:campaign) { FactoryBot.create(:campaign, test_contacts_file: file) }
        it { expect(campaign.test_contacts.count).to eq(2) }
        it { expect(campaign.test_contacts.first['email']).to eq('test@test.com') }
      end

      context 'when file has a wrong file structure' do
        let(:file) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'wrong_contacts.csv')) }
        let(:campaign) { FactoryBot.create(:campaign, test_contacts_file: file) }
        it { expect(campaign.test_contacts.count).to eq(2) }
        it { expect(campaign.test_contacts.first['email']).to eq(nil) }
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

  describe '.count_contacts' do
    let(:campaign) { FactoryBot.create(:campaign, send_at: 1.hour.from_now) }
    before { campaign.count_contacts }
    it { expect(campaign.contacts_count).to eq(2) }
  end

  describe '.can_send?' do
    context 'when sending test email' do
      let(:campaign) { FactoryBot.create(:campaign, enabled: false) }
      it { expect(campaign.can_send?(true)).to be(true) }
    end
    context 'when sending production email' do
      context 'when campaign is enabled' do
        let(:campaign) { FactoryBot.create(:campaign, enabled: true) }
        it { expect(campaign.can_send?).to be(true) }
      end
      context 'when campaign is disabled' do
        let(:campaign) { FactoryBot.create(:campaign, enabled: false) }
        it { expect(campaign.can_send?).to be(false) }
      end
    end
  end

  describe '.send_test' do
    let(:campaign) { FactoryBot.create(:campaign) }
    before { allow(campaign).to receive(:test_contacts).and_return([{'email' => 'test@test.com'}]) }
    it 'counts contacts on save' do
      expect_any_instance_of(EmailSenderWorker).to receive(:perform).with(campaign.id, {'email' => 'test@test.com'}, true)
      campaign.send_test
    end
  end

  describe '.generate_mail' do
    
  end

end
