class User < ActiveRecord::Base
  attr_accessible :name, :profile_url, :email, :native_language, :learn_language, :message

  has_many :meetings
  has_many :appointments_from_me, :class_name => "Appointment", :foreign_key => :sender_id
  has_many :appointments_to_me, :class_name => "Appointment", :foreign_key => :recipient_id

  validates :name, presence: true
  validates :profile_url, presence: true, uniqueness: true, format: { with: /\A[a-z0-9_]+\z/,
    :message => I18n.t("only_letters_and_number_allowed") }
  validates :email, presence: true

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name ||= auth.info.name
      user.profile_url ||= auth.uid
      user.email ||= auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
