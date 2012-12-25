require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.build(:user).should be_valid
  end

  it "is invalid without name" do
    FactoryGirl.build(:user, name: "").should_not be_valid
  end

  it "is invalid without profile url" do
    FactoryGirl.build(:user, profile_url: "").should_not be_valid
  end

  it "is valid with profile url include letter or underscore words" do
    FactoryGirl.build(:user, profile_url: "taro1_2").should be_valid
  end

  it "is invalid with profile url include not letter or underscore words" do
    FactoryGirl.build(:user, profile_url: "taro@").should_not be_valid
  end

  it "is invalid with profile url not uniqueness" do
    FactoryGirl.create(:user, profile_url: "taroyamada")
    FactoryGirl.build(:user, profile_url: "taroyamada").should_not be_valid
  end

  it "is invalid without email" do
    FactoryGirl.build(:user, email: "").should_not be_valid
  end
end
