# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

lauren = Teacher.where(first_name: "Lauren", last_name: "Imparato").first
jules = Teacher.where(first_name: "Jules").first
heather = Teacher.where(first_name: "Heather").first
jeffrey = Teacher.where(first_name: "Jeffrey", last_name: "Villanueva").first
mimi = Teacher.where(first_name: "Mimi").first

  [lauren, jules, heather, jeffrey, mimi].each do |teacher|
    teacher.favorite = true
    teacher.save
  end
