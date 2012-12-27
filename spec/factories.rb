#-*- coding: utf-8 -*-

def r_str
  SecureRandom.hex(3)
end

FactoryGirl.define do
  factory :user do
    provider "facebook"
    sequence(:uid) { |n| n }
    sequence(:name) { |n| "Taro#{n}#{r_str}" }
    oauth_token SecureRandom.hex(30)
    oauth_expires_at 3.month.since(Date.today)
    native_language "ja"
    learn_language "zh-TW"
    message "一緒に言語交換しませんか？"
    sequence(:email) { |n| "taro#{n}#{r_str}@languageship.com" }
    getting_started false
    sequence(:profile_url) { |n| "taro#{n}" }
  end

  factory :meeting do
    date Date.today
    location "どこか"
    address "どこか"
    message "よろしくお願いします！"
    teach_language "ja"
    study_language "zh-TW"
    success false
    close false
    start_hour "10"
    start_minute "00"
    end_hour "12"
    end_minute "00"
    user
  end

  factory :invalid_meeting, parent: :meeting do
    location nil
  end
end
