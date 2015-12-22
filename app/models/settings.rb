class Settings < RailsSettings::CachedSettings
  def self.create_csv type  
    require 'csv'     
    @accepted_users = Submitter.joins(type).where("accepted = true").select("first_name", "last_name", "bio", "school", "teacher", "{type}.title")
    puts @accepted_users
    csv_string = CSV.generate do |csv|
       csv << ["First Name", "Last Name", "Bio", "School", "Teacher", "Title"]
       @accepted_users.each do |user|
         csv << [user.first_name, user.last_name, user.bio, user.school, user.teacher, user.title]
       end
    end
    puts csv_string
  end      
end
