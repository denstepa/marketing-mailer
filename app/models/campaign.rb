# frozen_string_literal: true

class Campaign < ApplicationRecord

  validates_presence_of :contacts_file

  mount_uploader :contacts_file, DefaultUploader

end
