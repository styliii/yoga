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
julianna = Teacher.where(first_name: "Julianna").first
kelly = Teacher.where(first_name: "Kelly").first


  [lauren, jules, heather, jeffrey, mimi, kelly].each do |teacher|
    teacher.favorite = true
    teacher.save
  end

shala = Studio.where(name: "Shala Union Square").first
shala.location = "815 Broadway, New York, NY"
shala.save

jivamukti = Studio.where(name: "Jivamukti").first
jivamukti.location = "841 Broadway #2, New York, NY 10003"
jivamukti.save

iamyou = Studio.where(name: "iamyoustudio").first
iamyou.location = "132 Mulberry St #6e, New York, NY 10013"
iamyou.save

yogavida = Studio.where(name: "Yoga Vida 99 University").first
yogavida.location = "99 University Pl #6, New York, NY 10003"
yogavida.save

