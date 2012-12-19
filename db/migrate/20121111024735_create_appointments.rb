class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :meeting_id
      t.integer :sender_id
      t.integer :recipient_id
      t.text :message
      t.boolean :accept, :default => :false
      t.boolean :reject, :default => :false

      t.timestamps
    end
  end
end
