class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
end
