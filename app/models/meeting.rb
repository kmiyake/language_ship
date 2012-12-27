class Meeting < ActiveRecord::Base
  attr_accessible :address, :close, :date, :end_hour, :end_minute, :location, :message, :start_hour, :start_minute, :study_language, :success, :teach_language, :user_id

  belongs_to :user

  has_many :appointments

  validate :before_today,
    :start_time_cannot_be_in_past_than_end_time

  validates :location, :presence => true
  validates :address, :presence => true

  def self.before_today
    where("date >= :today", { today: Date.today })
  end

  def self.by_name(name)
    users = User.where("name LIKE '%#{name}%'")
    where("user_id in (:ids)", ids: users).order("date DESC")
  end

  def guest_user
    appointments.where(accept: true).first.sender
  end

  def render_time
    "#{start_hour}:#{start_minute} - #{end_hour}:#{end_minute}"
  end

  def is_past?
    date < Date.today
  end

  private

  def before_today
    errors.add(:date, I18n.t(".cant_be_in_the_past")) if date < Date.today
  end

  def start_time_cannot_be_in_past_than_end_time
    start_time = start_hour + start_minute
    end_time = end_hour + end_minute
    if start_time.to_i >= end_time.to_i
      errors.add(:end_time, I18n.t(".cant_be_in_the_past_than_start_time"))
    else
      true
    end
  end
end
