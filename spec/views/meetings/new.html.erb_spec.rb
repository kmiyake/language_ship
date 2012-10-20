require 'spec_helper'

describe "meetings/new" do
  before(:each) do
    assign(:meeting, stub_model(Meeting,
      :user_id => 1,
      :start_time => "MyString",
      :end_time => "MyString",
      :location => "MyString",
      :address => "MyString",
      :message => "MyText",
      :teach_language => "MyString",
      :study_language => "MyString",
      :success => false,
      :close => false
    ).as_new_record)
  end

  it "renders new meeting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => meetings_path, :method => "post" do
      assert_select "input#meeting_user_id", :name => "meeting[user_id]"
      assert_select "input#meeting_start_time", :name => "meeting[start_time]"
      assert_select "input#meeting_end_time", :name => "meeting[end_time]"
      assert_select "input#meeting_location", :name => "meeting[location]"
      assert_select "input#meeting_address", :name => "meeting[address]"
      assert_select "textarea#meeting_message", :name => "meeting[message]"
      assert_select "input#meeting_teach_language", :name => "meeting[teach_language]"
      assert_select "input#meeting_study_language", :name => "meeting[study_language]"
      assert_select "input#meeting_success", :name => "meeting[success]"
      assert_select "input#meeting_close", :name => "meeting[close]"
    end
  end
end
