class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html  

  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @submitters = Submitter.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def admin_tools
    @unapproved_editors = Editor.where(approved: false)
    @approved_editors = Editor.where(approved: true)
    @admins = Admin.all
  end

  def toggle_admin_role
    set_user
    if @user == current_user
      flash.alert = "You cannot edit your own admin status"
    else 
      @user.toggle_admin
      flash.notice = @user.name + "'s role has been changed to " + @user.role
    end
    redirect_to admin_tools_users_path
  end

  def toggle_approved_status
    set_user
    @user.toggle(:approved)
    @user.save
    if (@user.approved)
      flash.notice = @user.name + " is now an approved editor."
    else
      flash.notice = @user.name + " is no longer an approved editor"
    end
    redirect_to admin_tools_users_path
  end

  def new_submitter
    @user = Submitter.new
  end

  def create_submitter
    @submitter = Submitter.new(submitter_params)
    @submitter.random_pw
    if @submitter.save
      UserMailer.account_for_you(@submitter).deliver
      flash.notice = "You have successfully added " + @submitter.name + "."
      redirect_to user_path(@submitter)
    else 
      flash.notice = "Save failed!  Try again."
      redirect_to :back
    end
  end

  def edit
  end

  def update
    ## Most user updates should occur using the devise edit_registration_path.  This is only for admins to edit other users.
      if params[:submitter][:password].blank?
        params[:submitter].delete(:password)
        params[:submitter].delete(:password_confirmation)
      end
     if @user.update(submitter_params)
      flash.notice = @user.name + " was updated successfully."
      redirect_to user_path(@user)
    else 
      render :edit
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submitter_params
      params.require(:submitter).permit(:first_name, :last_name, :school, :grade, :teacher, :bio, :email, :password, :password_confirmation)
    end
end
