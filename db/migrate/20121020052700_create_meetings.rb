class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.integer :user_id
      t.date :date
      t.string :start_time
      t.string :end_time
      t.string :location
      t.string :address
      t.text :message
      t.string :teach_language
      t.string :study_language
      t.boolean :success
      t.boolean :close

      t.timestamps
    end
  end
end
