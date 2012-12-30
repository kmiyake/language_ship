require "spec_helper"

def return_omniauth_env(user)
  env = {}
  env['omniauth.auth'] = OmniAuth::AuthHash.new({
    :provider => user.provider,
    :uid => user.uid,
    :info => {
      :email => user.email,
      :name => user.name
    },
    :credentials => {
      :token => user.oauth_token,
      :expires_at => user.oauth_expires_at
    }
  })
  env
end

describe SessionsController do
  it "redirect to edit account path if getting started" do
    user = FactoryGirl.create(:user, getting_started: true)
    env = return_omniauth_env(user)
    controller.stub!(:env).and_return(env)
    get :create
    response.should redirect_to edit_account_path
  end
  
  it "redirect to meetings path unless getting started" do
    user = FactoryGirl.create(:user, getting_started: false)
    env = return_omniauth_env(user)
    controller.stub!(:env).and_return(env)
    get :create
    response.should redirect_to meetings_path
  end

  it "redirect to root path if signd out" do
    delete :destroy
    session[:user_id].should be_nil
    response.should redirect_to root_path
  end
end
