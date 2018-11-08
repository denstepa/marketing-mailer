require "administrate/base_dashboard"

class CampaignDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    send_at: Field::DateTime,
    contacts_file: Field::Carrierwave.with_options(
      remove: false,
      remote_url: false
    ),
    test_contacts_file: Field::Carrierwave.with_options(
      remove: false,
      remote_url: false
    ),
    contacts_count: Field::Number,
    subject: Field::String,
    template: Field::String,
    internal_name: Field::String,
    enabled: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :send_at,
    :internal_name,
    :contacts_count,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :send_at,
    :contacts_file,
    :test_contacts_file,
    :contacts_count,
    :subject,
    :template,
    :internal_name,
    :enabled
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :send_at,
    :contacts_file,
    :test_contacts_file,
    :contacts_count,
    :subject,
    :template,
    :internal_name,
    :enabled,
  ].freeze

  # Overwrite this method to customize how campaigns are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(campaign)
  #   "Campaign ##{campaign.id}"
  # end
end
