class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  %w(Submitter Editor Admin).each do |k| 
    define_method "current_#{k.underscore}" do 
        current_user if current_user.is_a?(k.constantize)
    end 

    define_method "authenticate_#{k.underscore}!" do 
    |opts={}| send("current_#{k.underscore}") || not_authorized 
    end 
  end
  
end
