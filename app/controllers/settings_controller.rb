class SettingsController < ApplicationController
  def index
    # to get all items for render list
    @settings = Settings.unscoped
  end

  def edit
    @setting = Settings.unscoped.find(params[:id])
  end

  def update
    @setting = Settings.unscoped.find(params[:id])
    if @setting.var = "accepting_submissions"
      if params[:accepting_submissions] then Settings.accepting_submissions = true else Settings.accepting_submissions = false end
    end
    render json: Settings.accepting_submissions
  end
end