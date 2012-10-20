class Meeting < ActiveRecord::Base
  attr_accessible :address, :close, :date, :end_time, :location, :message, :start_time, :study_language, :success, :teach_language, :user_id
end
