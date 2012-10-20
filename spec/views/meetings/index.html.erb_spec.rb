require 'spec_helper'

describe "meetings/index" do
  before(:each) do
    assign(:meetings, [
      stub_model(Meeting,
        :user_id => 1,
        :start_time => "Start Time",
        :end_time => "End Time",
        :location => "Location",
        :address => "Address",
        :message => "MyText",
        :teach_language => "Teach Language",
        :study_language => "Study Language",
        :success => false,
        :close => false
      ),
      stub_model(Meeting,
        :user_id => 1,
        :start_time => "Start Time",
        :end_time => "End Time",
        :location => "Location",
        :address => "Address",
        :message => "MyText",
        :teach_language => "Teach Language",
        :study_language => "Study Language",
        :success => false,
        :close => false
      )
    ])
  end

  it "renders a list of meetings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Start Time".to_s, :count => 2
    assert_select "tr>td", :text => "End Time".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Teach Language".to_s, :count => 2
    assert_select "tr>td", :text => "Study Language".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
