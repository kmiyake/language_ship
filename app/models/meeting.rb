class Meeting < ActiveRecord::Base
  attr_accessible :address, :close, :date, :end_time, :location, :message, :start_time, :study_language, :success, :teach_language, :user_id

  belongs_to :user

  has_many :appointments

  validate :before_today,
    :start_time_cannot_be_in_past_than_end_time
  validates :address, :presence => true

  def self.before_today
    where("date >= :today", { today: Date.today })
  end

  def guest_user
    appointments.where(accept: true).first.sender
  end

  def time
    st,et = start_time.dup, end_time.dup
    "#{st.insert(2, ":")} - #{et.insert(2, ":")}"
  end

  def start_hour
    start_time[0..1].to_i || 0 if start_time
  end

  def start_minute
    start_time[2..3].to_i || 0 if start_time
  end

  def end_hour
    end_time[0..1].to_i || 0 if end_time
  end

  def end_minute
    end_time[2..3].to_i || 0 if end_time
  end

  def is_past?
    date < Date.today
  end

  private

  def before_today
    errors.add(:date, I18n.t(".cant_be_in_the_past")) if date < Date.today
  end

  def start_time_cannot_be_in_past_than_end_time
    if start_time.to_i >= end_time.to_i
      errors.add(:end_time, I18n.t(".cant_be_in_the_past_than_start_time"))
    else
      true
    end
  end
end
