class Submitter < User;

  validates :school, :teacher, :grade, :bio, presence: true

  schools_string = "Central Middle School (San Carlos),JLS Middle School,Tierra Linda Middle School,Marin Teen Poets,North Star Academy,Citizen Schools/Cesar Chavez,Synapse School ,Sierramont Middle School,Martin Luther King Jr Middle School,California School for the Deaf,Sunol Glen School,Hopkins Junior High,Creekside Middle School,River Glen School,Pleasanton Middle School,Kennedy Middle School,Jordan Middle School,49ers Academy,Ronald McNair Middle School,Willow Oaks,East Palo Alto Charter School,East Palo Alto Phoenix Academy,El Portal Middle School,Harvest Park Middle School,Nea CLC,Union Middle School,Pine Valley Middle School,Raymond J Fisher Middle School,Mathson Middle School,Seven Hills School,Valley View Charter Prep,Joaquin Miller Middle School,Joaquin Moraga Intermediate,Thomas S Hart Middle School,Coliseum College Prep Academy,Montera Middle School,Chaboya Middle School,Saint Raymond School,Horner Junior High,Bullis Charter School,Peterson Middle School,Other,Homeschooled"

  SCHOOLS = schools_string.split(",").sort

  GRADES = [6, 7, 8]

end