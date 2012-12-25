require 'spec_helper'

describe Meeting do
  it "has a valid factory" do
    FactoryGirl.build(:meeting).should be_valid
  end

  it "is invalid date before today" do
    FactoryGirl.build(:meeting, date: 1.day.ago(Date.today)).should_not be_valid
  end

  it "is invalud end time less than start time" do
    FactoryGirl.build(
      :meeting,
      start_hour: "10", start_minute: "00",
      end_hour: "09", end_minute: "00"
    ).should_not be_valid
  end

  it "is invalid without location" do
    FactoryGirl.build(:meeting, location: "").should_not be_valid
  end

  it "is invalid without address" do
    FactoryGirl.build(:meeting, address: "").should_not be_valid
  end

  it "returns a sorted array of results that match" do
    smith = FactoryGirl.create(:user, name: "smith")
    bob = FactoryGirl.create(:user, name: "bob")
    taro = FactoryGirl.create(:user, name: "taro")

    smith_meeting = FactoryGirl.create(:meeting, user: smith)
    bob_meeting = FactoryGirl.create(:meeting, user: bob)
    taro_meeting = FactoryGirl.create(:meeting, user: taro)
    Meeting.by_name("taro").should == [taro_meeting]
  end
end
