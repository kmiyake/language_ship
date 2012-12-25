#-*- coding: utf-8 -*-
require 'spec_helper'

describe MeetingsController do
  before do
    @user = FactoryGirl.create(:user)
    @meeting = FactoryGirl.create(:meeting, :user => @user)
  end

  context '#index' do
    it 'should be success' do
      get :index
      response.should be_success
    end
  end

  context '#created' do
    it 'should be success' do
      get :created
      response.should be_success
    end
  end

  context '#today' do
    it 'should be success' do
      get :today
      response.should be_success
    end
  end

  context '#search' do
    context 'with name' do
      it 'should be success' do
        get :search, name: 'kota'
        response.should be_success
      end
    end

    context 'with teach_language' do
      it 'should be success' do
        get :search, teach_language: 'zh-TW'
        response.should be_success
      end
    end
  end

  context '#show' do
    it "should be success" do
      get :show, id: @meeting.id
      response.should be_success
    end
  end

  context '#new' do
    it "should be success" do
      session[:user_id] = @user.id
      get :new, id: @meeting.id
      response.should be_success
    end
  end

  context '#edit' do
    it "should be success" do
      session[:user_id] = @user.id
      get :edit, id: @meeting.id
      response.should be_success
    end
  end
end
