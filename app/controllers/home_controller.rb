class HomeController < ApplicationController
  def show
    if current_user
      render 'show'
    else
      render 'welcome'
    end
  end
end
