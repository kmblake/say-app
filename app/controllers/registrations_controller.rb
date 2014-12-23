
class RegistrationsController < Devise::RegistrationsController

  def create
    super
    if resource.persisted?
      UserMailer.welcome_email(resource).deliver
    end
  end
 
  private
  def sign_up_params
    params.require(resource_name).permit(:first_name, :last_name, :school, :grade, :teacher, :bio, :email, :password, :password_confirmation)
  end
 
  def account_update_params
    params.require(resource_name).permit(:first_name, :last_name, :school, :grade, :teacher, :bio, :email, :password, :password_confirmation, :current_password)
  end

  def after_sign_up_path_for(resource)
    root_path
  end
end