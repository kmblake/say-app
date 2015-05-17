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
    if @setting.var == "accepting_submissions"
      if params[:accepting_submissions] then Settings.accepting_submissions = true else Settings.accepting_submissions = false end
      elsif @setting.var == "finalized"
        if params[:finalized] then Settings.finalized = true else Settings.finalized = false end
        end
        render json: @setting
  end

  def export_to_csv  
    require 'csv'     
    @accepted_users_docs = Submitter.joins(:documents).where("accepted = true").select("first_name", "last_name", "bio", "school", "teacher", "email", "documents.title", "documents.style")
    @accepted_users_art = Submitter.joins(:artworks).where("accepted = true").select("first_name", "last_name", "bio", "school", "teacher", "email", "artworks.title")
    csv_string = CSV.generate do |csv|
       csv << ["First Name", "Last Name", "Bio", "School", "Teacher", "Type", "Title"]
       @accepted_users_docs.each do |user|
         csv << [user.first_name, user.last_name, user.email, user.bio, user.school, user.teacher, user.style, user.title]
       end
       @accepted_users_art.each do |user|
         csv << [user.first_name, user.last_name, user.email, user.bio, user.school, user.teacher, "Art", user.title]
       end
    end         

    send_data csv_string,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=accepted_users.csv" 
  end 
end