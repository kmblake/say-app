class SubmissionsController < ApplicationController
  def show
    @user = current_user
  end

  def showall
  	@submitters = User.all
  end
end
