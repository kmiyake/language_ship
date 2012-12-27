#-*- coding: utf-8 -*-
require 'spec_helper'

describe MeetingsController do
  describe "GET #index" do
    it "populates an array of meetings" do
      meeting = FactoryGirl.create(:meeting)
      get :index
      assigns(:meetings).should eq([meeting])
    end

    it "should be success" do
      get :index
      response.should be_success
    end

    it "renders :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #created" do
    it "populates an array of meetings" do
      meeting = FactoryGirl.create(:meeting)
      get :created
      assigns(:meetings).should eq([meeting])
    end

    it "should be success" do
      get :created
      response.should be_success
    end
  end

  describe "GET #today" do
    it "should be success" do
      get :today
      response.should be_success
    end

    it "populates an array of today meetings" do
      before_today_meeting = FactoryGirl.build(:meeting, date: 1.day.ago(Date.today))
      before_today_meeting.save(validate: false)
      today_meeting = FactoryGirl.create(:meeting, date: Date.today)
      after_today_meeting = FactoryGirl.create(:meeting, date: 1.day.since(Date.today))
      get :today
      assigns(:meetings).should eq([today_meeting])
    end

    it "is not include an array of not today meetings" do
      before_today_meeting = FactoryGirl.build(:meeting, date: 1.day.ago(Date.today))
      before_today_meeting.save(validate: false)
      today_meeting = FactoryGirl.create(:meeting, date: Date.today)
      after_today_meeting = FactoryGirl.create(:meeting, date: 1.day.since(Date.today))
      get :today
      assigns(:meetings).should_not include([before_today_meeting, after_today_meeting])
    end
  end

  describe "GET #search" do
    before do
      @taro = FactoryGirl.create(:user, name: "taro")
      @bob = FactoryGirl.create(:user, name: "bob")
      @tom = FactoryGirl.create(:user, name: "tom")
    end

    context "with name" do
      it "should be success" do
        get :search, name: "kota"
        response.should be_success
      end

      it "populates an array of match user meetings" do
        taro_meeting = FactoryGirl.create(:meeting, user: @taro)
        bob_meeting = FactoryGirl.create(:meeting, user: @bob)
        tom_meeting = FactoryGirl.create(:meeting, user: @tom)
        get :search, name: "t"
        assigns(:meetings).should eq([taro_meeting, tom_meeting])
      end

      it "is not include an array of unmatch user meetings" do
        taro_meeting = FactoryGirl.create(:meeting, user: @taro)
        bob_meeting = FactoryGirl.create(:meeting, user: @bob)
        tom_meeting = FactoryGirl.create(:meeting, user: @tom)
        get :search, name: "t"
        assigns(:meetings).should_not include([bob_meeting])
      end
    end

    context "with teach_language" do
      it "should be success" do
        get :search, teach_language: "zh-TW"
        response.should be_success
      end
    end
  end

  describe "GET #show" do
    it "should be success" do
      meeting = FactoryGirl.create(:meeting)
      get :show, id: meeting
      response.should be_success
    end

    it "assigns the requested meeting to @meeting" do
      meeting  = FactoryGirl.create(:meeting)
      get :show, id: meeting
      assigns(:meeting).should eq(meeting)
    end

    it "renders the :show view" do
      get :show, id: FactoryGirl.create(:meeting)
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "should be success" do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
      get :new
      response.should be_success
    end

    it "assigns the new meeting of user" do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
      get :new
      assigns(:meeting).user_id.should eq user.id
    end

    it "renders the :new view" do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
      get :new
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    before do
      @user = FactoryGirl.create(:user)
      @meeting  = FactoryGirl.create(:meeting, user: @user)
    end

    it "assigns the requested meeting to @meeting" do
      session[:user_id] = @user.id
      get :edit, id: @meeting
      assigns(:meeting).should eq(@meeting)
    end

    it "should be success" do
      session[:user_id] = @user.id
      get :edit, id: @meeting
      response.should be_success
    end

    it "renders the :edit view" do
      session[:user_id] = @user.id
      get :edit, id: @meeting
      response.should render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @user = FactoryGirl.create(:user)
        session[:user_id] = @user.id
      end

      it "create a new meeting" do
        expect{
          post :create, meeting: FactoryGirl.attributes_for(:meeting)
        }.to change(Meeting, :count).by(1)
      end

      it "redirects to the new contact" do
        post :create, meeting: FactoryGirl.attributes_for(:meeting)
        response.should redirect_to Meeting.last
      end
    end

    context "with invalid attributes" do
      before do
        @user = FactoryGirl.create(:user)
        session[:user_id] = @user.id
      end

      it "does not save the new meeting" do
        expect{
          post :create, meeting: FactoryGirl.attributes_for(:invalid_meeting)
        }.to_not change(Meeting, :count)
      end

      it "re-renders the :new view" do
        post :create, meeting: FactoryGirl.attributes_for(:invalid_meeting)
        response.should render_template :new
      end
    end
  end

  describe "PUT #update" do
    before do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
      @meeting = FactoryGirl.create(:meeting, location: "日本", address: "東京都浅草", user: @user)
    end

    context "with valid attributes" do
      it "locates the requested @meeting" do
        put :update, id: @meeting, meeting: FactoryGirl.attributes_for(:meeting)
        assigns(:meeting).should eq(@meeting)
      end

      it "changes @meeting's attributes" do
        put :update, id: @meeting,
          meeting: FactoryGirl.attributes_for(:meeting, location: "台湾", address: "台北市")
        @meeting.reload
        @meeting.location.should eq("台湾")
        @meeting.address.should eq("台北市")
      end

      it "redirects to the updated meeting" do
        put :update, id: @meeting, meeting: FactoryGirl.attributes_for(:meeting)
        response.should redirect_to @meeting
      end
    end

    context "with invalid attributes" do
      it "locates the requested @meeting" do
        put :update, id: @meeting, meeting: FactoryGirl.attributes_for(:invalid_meeting)
        assigns(:meeting).should eq(@meeting)
      end

      it "does not change @meeting's attributes" do
        put :update, id: @meeting,
          meeting: FactoryGirl.attributes_for(:meeting, location: "台湾", address: nil)
        @meeting.reload
        @meeting.location.should_not eq("台湾")
        @meeting.address.should eq("東京都浅草")
      end

      it "re-renders the edit method" do
        put :update, id: @meeting, meeting: FactoryGirl.attributes_for(:invalid_meeting)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
      @meeting = FactoryGirl.create(:meeting, user: @user)
    end

    it "deletes the meeting" do
      expect{
        delete :destroy, id: @meeting
      }.to change(Meeting,:count).by(-1)
    end

    it "redirects to meetings#index" do
      delete :destroy, id: @meeting
      response.should redirect_to meetings_url
    end
  end
end
