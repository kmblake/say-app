# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Editor.create!(first_name: 'John' , last_name: 'Doe', email: 'jdoe@kent.com', password: 'test123')
Editor.create!(first_name: 'Jane', last_name: 'Doe', email: 'janedoe@kent.com', password: 'test123')
Editor.create!(first_name: 'JK', last_name: 'Rowling', email: 'jk@kent.com', approved: true, password: 'test123')

Submitter.create!(first_name: 'Charles' , last_name: 'Dickens', email: 'dickens@kent.com', password: 'test123', school: 'Tierra Linda Middle School', grade: '6', teacher: 'God Herself', bio: 'Test User')
Submitter.create!(first_name: 'Charlotte' , last_name: 'Bronte', email: 'bronte@kent.com', password: 'test123', school: 'Central Middle School (San Carlos)', grade: '7', teacher: 'God Herself', bio: 'Test User')