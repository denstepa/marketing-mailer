FactoryBot.define do
  factory :campaign do
    contacts_file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'test_contacts.csv')) }
  end
end