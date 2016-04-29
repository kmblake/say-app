class Settings < RailsSettings::CachedSettings
  def self.generate_cvs_string(users_docs, users_art)
    require 'csv'     
    csv_string = CSV.generate do |csv|
       csv << ["First Name", "Last Name", "Email", "Bio", "School", "Teacher", "Type", "Title"]
       users_docs.each do |user|
         csv << [user.first_name, user.last_name, user.email, user.bio, user.school, user.teacher, user.style, user.title]
       end
       users_art.each do |user|
         csv << [user.first_name, user.last_name, user.email, user.bio, user.school, user.teacher, "Art", user.title]
       end
    end
  end   
end
