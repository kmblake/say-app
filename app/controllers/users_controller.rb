class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

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
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def admin_tools
    @unapproved_editors = Editor.where(approved: false)
    @approved_editors = Editor.where(approved: true)
    @admins = Admin.all
  end

  def convert_to_admin
    set_user
    if (@user.role == "Editor")
      @user.convert_to_admin
      @user.save
      flash.notice = @user.name + " is now an admin!"
    else
      flash.alert = @user.name " is not an editor.  Cannot convert to admin."
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
