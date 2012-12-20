require 'spec_helper'

describe Meeting do
  fixtures :meetings

  context '#date' do
    it 'should not be valid with before today' do
      @meeting = meetings(:before_today_meeting)
      @meeting.should_not be_valid
    end
  end
end
