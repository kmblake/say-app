def populate_if_not_nil(setting, default)
  if Settings[setting].nil?
    Settings[setting] = default
  end
end

populate_if_not_nil('accepting_submissions', true)
populate_if_not_nil('finalized', false)
populate_if_not_nil('show_ratings', false)
populate_if_not_nil('schools', ["49ers Academy", "Blach Middle School", "Bullis Charter School", "California School for the Deaf", "Central Middle School (San Carlos)", "Chaboya Middle School", "Citizen Schools/Cesar Chavez", "Coliseum College Prep Academy", "Creekside Middle School", "East Palo Alto Charter School", "East Palo Alto Phoenix Academy", "El Portal Middle School", "Harvest Park Middle School", "Homeschooled", "Hopkins Junior High", "Horner Junior High", "JLS Middle School", "Joaquin Miller Middle School", "Joaquin Moraga Intermediate", "Jordan Middle School", "Kennedy Middle School", "Marin Teen Poets", "Martin Luther King Jr Middle School", "Mathson Middle School", "Montera Middle School", "Nea CLC", "North Star Academy", "Other", "Peterson Middle School", "Pine Valley Middle School", "Pleasanton Middle School", "Raymond J Fisher Middle School", "River Glen School", "Ronald McNair Middle School", "Saint Raymond School", "Seven Hills School", "Sierramont Middle School", "Sunol Glen School", "Synapse School ", "Thomas S Hart Middle School", "Tierra Linda Middle School", "Union Middle School", "Valley View Charter Prep", "Willow Oaks"])