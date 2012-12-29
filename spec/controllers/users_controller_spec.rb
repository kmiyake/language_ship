require 'spec_helper'

describe UsersController do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe "GET #show" do
    it "renders the :show view" do
      get :show, profile_url: @user.profile_url
      response.should render_template :show
    end
  end

  describe "GET #edit" do
    context "logged in" do
      it "renders the :edit view" do
        sign_in(@user)
        get :edit, id: @user
        response.should render_template :edit
      end
    end

    context "not logged in" do
      it "redirects to root path" do
        get :edit, id: @user
        response.should redirect_to root_path
      end
    end
  end

  describe "PUT #update" do
    before do
      @attributes = FactoryGirl.attributes_for(:user)
      @attributes.delete(:provider)
      @attributes.delete(:uid)
      @attributes.delete(:oauth_token)
      @attributes.delete(:oauth_expires_at)
      @attributes.delete(:getting_started)
    end

    context "logged in" do
      it "redirects to user profile path" do
        sign_in(@user)
        put :update, id: @user, user: @attributes
        response.should redirect_to user_profile_path(@user.profile_url)
      end
    end

    context "not logged in" do
      it "redirects to root path" do
        put :update, id: @user, user: @attributes
        response.should redirect_to root_path
      end
    end
  end

  describe "GET #meetings" do
    it "renders the :show view" do
      get :meetings, profile_url: @user.profile_url
      response.should render_template :show
    end
  end

  describe "GET #successes" do
    it "renders the :show view" do
      get :successes, profile_url: @user.profile_url
      response.should render_template :show
    end
  end
end
