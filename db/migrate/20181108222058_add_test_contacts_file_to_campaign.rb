class AddTestContactsFileToCampaign < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :test_contacts_file, :string
    add_column :campaigns, :enabled, :boolean
  end
end
