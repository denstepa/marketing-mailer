class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.datetime :send_at
      t.string :contacts_file
      t.integer :contacts_count
      t.string :subject
      t.string :template
      t.string :internal_name

      t.timestamps
    end
  end
end
