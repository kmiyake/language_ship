class ChangeStartTimeAndEndTimeToMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :start_time
    remove_column :meetings, :end_time
    add_column :meetings, :start_hour, :string, :default => "00", :null => false
    add_column :meetings, :start_minute, :string, :default => "00", :null => false
    add_column :meetings, :end_hour, :string, :default => "00", :null => false
    add_column :meetings, :end_minute, :string, :default => "00", :null => false
  end
end
