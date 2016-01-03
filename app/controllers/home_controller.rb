class HomeController < ApplicationController
  def index
  	if !current_user
    	redirect_to new_user_session_path
    elsif !current_submitter and current_user.approved
        redirect_to documents_path
    end
  end

  def help
  end
end
