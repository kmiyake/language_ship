class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.integer :user_id
      t.date :date,                                :null => false
      t.string :start_time,                        :null => false
      t.string :end_time,                          :null => false
      t.string :location
      t.string :address,                           :null => false
      t.text :message
      t.string :teach_language,                    :null => false
      t.string :study_language,                    :null => false
      t.boolean :success,       :default => false, :null => false
      t.boolean :close,         :default => false, :null => false

      t.timestamps
    end
  end
end
