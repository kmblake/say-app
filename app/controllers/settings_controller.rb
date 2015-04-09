class SettingsController < ApplicationController

  def index
    # to get all items for render list
    unless current_admin then raise(CanCan::AccessDenied, 'You are not authorized to access this page.') end
    @settings = Settings.unscoped
  end

  def edit
    @setting = Settings.unscoped.find(params[:id])
  end

  def update
    @setting = Settings.unscoped.find(params[:id])
    if @setting.var == "accepting_submissions"
      if params[:accepting_submissions] then Settings.accepting_submissions = true else Settings.accepting_submissions = false end
    elsif @setting.var == "finalized"
      if params[:finalized] then Settings.finalized = true else Settings.finalized = false end
    end
    render json: @setting
  end
end