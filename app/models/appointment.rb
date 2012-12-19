class Appointment < ActiveRecord::Base
  attr_accessible :accept, :meeting_id, :message, :recipient_id, :reject, :sender_id

  belongs_to :meeting
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
end
