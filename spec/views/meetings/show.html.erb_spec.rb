require 'spec_helper'

describe "meetings/show" do
  before(:each) do
    @meeting = assign(:meeting, stub_model(Meeting,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Start Time/)
    rendered.should match(/End Time/)
    rendered.should match(/Location/)
    rendered.should match(/Address/)
    rendered.should match(/MyText/)
    rendered.should match(/Teach Language/)
    rendered.should match(/Study Language/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
