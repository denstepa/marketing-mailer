class AddFromToCampaign < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :from, :string
  end
end
