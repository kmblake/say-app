class HomeController < ApplicationController
  def index
    redirect_to new_user_session_path unless current_user
    @submitters = User.all
  end

  def help
  end
end
