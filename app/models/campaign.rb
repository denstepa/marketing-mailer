# frozen_string_literal: true
require 'csv'
require 'sendgrid-ruby'

class Campaign < ApplicationRecord

  include SendGrid

  # validates_presence_of :contacts_file

  mount_uploader :contacts_file, DefaultUploader
  mount_uploader :test_contacts_file, DefaultUploader

  before_save :count_contacts

  def contacts
    @contacts ||= begin
      ::CSV.read(contacts_file.path, headers: true) if contacts_file.present?
    end
  end

  def test_contacts
    @test_contacts ||= begin
      ::CSV.read(test_contacts_file.path, headers: true) if test_contacts_file.present?
    end
  end

  def schedule
    contacts.each do |contact|
      EmailSenderWorker.perform_at(send_at, id, contact.to_hash)
    end
  end

  def generate_mail(contact_data)
    mail = SendGrid::Mail.new
    mail.from = Email.new(email: 'denis@inkitt.com')
    mail.template_id = template

    personalization = Personalization.new
    personalization.add_to(Email.new(contact_data.slice(:email, :name)))
    personalization.subject = subject
    personalization.add_dynamic_template_data(contact_data)
    mail.add_personalization(personalization)
    mail
  end

  def deliver_email!(contact_data)
    mail = generate_mail(contact_data.symbolize_keys)
    SendgridSender.deliver!(mail)
  end

  def count_contacts
    self.contacts_count = contacts&.count
  end

  def send_test
    test_contacts.each do |contact|
      EmailSenderWorker.new.perform(id, contact.to_hash, true)
    end
  end

  def can_send?(is_test = false)
    is_test || enabled?
  end

end
