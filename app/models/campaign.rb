# frozen_string_literal: true
require 'csv'

class Campaign < ApplicationRecord

  validates_presence_of :contacts_file

  mount_uploader :contacts_file, DefaultUploader

  def contacts
    @contacts ||= begin
      ::CSV.read(contacts_file.path, headers: true)
    end
  end

  def schedule
    contacts.each do |contact|
      EmailSenderWorker.perform_at(send_at, id, contact.as_json)
    end
  end

  def generate_mail
    mail = SendGrid::Mail.new(Email.new(email: 'denis@inkitt.com'))
    mail.from = Email.new(email: from)
    mail.template_id = template

    personalization = Personalization.new
    personalization.add_to(Email.new(email: 'denstepa@gmail.com', name: 'Example User'))
    personalization.subject = subject
    personalization.add_dynamic_template_data(name: 'test name')
    mail.add_personalization(personalization)
  end

  def send_email
    mail = generate_mail
    SendgridSender.deliver!(mail)
  end

end
