require 'spec_helper'

describe AppointmentsController do
  describe "GET #new" do
    before do
      @owner = FactoryGirl.create(:user)
      @guest = FactoryGirl.create(:user)
      @meeting = FactoryGirl.create(:meeting, user: @owner)
    end

    context "logged in" do
      before do
        sign_in(@guest)
      end

      it "should be success" do
        get :new, meeting_id: @meeting
        response.should be_success
      end

      it "assigns the new meeting of user" do
        get :new, meeting_id: @meeting
        assigns(:appointment).sender_id.should eq @guest.id
        assigns(:appointment).recipient_id.should eq @owner.id
      end

      it "renders the :new view" do
        get :new, meeting_id: @meeting
        response.should render_template :new
      end

      it "redirects to root url if current user == meeting owner user" do
        sign_in(@owner)
        get :new, meeting_id: @meeting
        response.should redirect_to root_url
      end

      context "already apply meeting" do
        it "redirects to meeting url" do
          post :create, meeting_id: @meeting.id,
            appointment: FactoryGirl.attributes_for(
              :appointment,
              :sender_id => @guest.id,
              :recipient_id => @owner.id)
          get :new, meeting_id: @meeting
          response.should redirect_to @meeting
        end
      end
    end

    context "not logged in" do
      it "should not be success" do
        get :new, meeting_id: @meeting
        response.should_not be_success
      end

      it "redirects to root url" do
        get :new, meeting_id: @meeting
        response.should redirect_to root_url
      end
    end
  end

  describe "POST #create" do
    before do
      @owner = FactoryGirl.create(:user)
      @guest = FactoryGirl.create(:user)
      @meeting = FactoryGirl.create(:meeting, user: @owner)
    end

    context "logged in" do
      before do
        session[:user_id] = @guest.id
      end

      it "create a new appointment" do
        expect{
          post :create, meeting_id: @meeting.id,
          appointment: FactoryGirl.attributes_for(:appointment,
                                                  :sender_id => @guest.id,
                                                  :recipient_id => @owner.id)
        }.to change(Appointment, :count).by(1)
      end

      it "redirects to the new contact" do
        post :create, meeting_id: @meeting.id,
          appointment: FactoryGirl.attributes_for(:appointment,
                                                  :sender_id => @guest.id,
                                                  :recipient_id => @owner.id)
        response.should redirect_to @meeting
      end
    end

    context "not logged in" do
      it "should not be success" do
        post :create, meeting_id: @meeting,
          appointment: FactoryGirl.attributes_for(:appointment,
                                                  :sender_id => @guest.id,
                                                  :recipient_id => @owner.id)
        response.should_not be_success
      end

      it "redirects to root url" do
        post :create, meeting_id: @meeting,
          appointment: FactoryGirl.attributes_for(:appointment,
                                                  :sender_id => @guest.id,
                                                  :recipient_id => @owner.id)
        response.should redirect_to root_url
      end
    end
  end
end
