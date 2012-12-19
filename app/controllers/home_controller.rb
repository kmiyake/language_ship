class HomeController < ApplicationController
  def show
    @users = User.order("created_at DESC")

    render 'show'
  end
end
