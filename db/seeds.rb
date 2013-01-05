# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


yc1 = YogaClass.create
yc1.studio = Studio.create(name: "I.AM.You Yoga", location: "132 Mulberry St")
yc1.teacher = Teacher.create(first_name: "Lauren", last_name: "Imparato")
yc1.day_of_week = DayOfWeek.find_by_name("Monday")

yc2 = YogaClass.create
yc2.studio = Studio.create(name: "I.AM.You Yoga", location: "132 Mulberry St")
yc2.teacher = Teacher.create(first_name: "Lauren", last_name: "Imparato")
yc2.day_of_week = DayOfWeek.find_by_name("Tuesday")

yc3 = YogaClass.create
yc3.studio = Studio.create(name: "I.AM.You Yoga", location: "132 Mulberry St")
yc3.teacher = Teacher.create(first_name: "Lauren", last_name: "Imparato")
yc3.day_of_week = DayOfWeek.find_by_name("Wednesday")

yc4 = YogaClass.create
yc4.studio = Studio.create(name: "I.AM.You Yoga", location: "132 Mulberry St")
yc4.teacher = Teacher.create(first_name: "Lauren", last_name: "Imparato")
yc4.day_of_week = DayOfWeek.find_by_name("Saturday")

