# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Student.destroy_all
Group.destroy_all
StudentGroup.destroy_all

cohort = Cohort.find_or_create_by(batch: 'dc-web-102819', name: '|dreams|', batch_id: 1157, current_mod: 6)

10.times do
  Student.find_or_create_by(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, cohort_id: cohort.id)
end

# projects = ['SWAPI', 'Toy Tale', 'Hogwarts', 'Task Lister', 'OO Pets']
# 102819
# ["Week 1 Table Groups", "OO Person 👯‍♀️ Pairing Lab", "SWAPI 👯‍♀️ Lab", "Task Lister", "OO Pets & Banking 👯‍♀️ Lab", "Sinatra 🎩🎙CRUD & RESTful Routes 👯‍♀️", "Dog CEO", "Hogwarts 👯‍♀️🧪", "Toy Tale 🧸", "Kickstarter 👯‍♀️ Lab", "🎩🎙 Pairing Activity", "Week 2 Table Groups", "Pairing: Has Many Through", "Pokemon Teams 👯‍♀️", "Mod 2 Week 2", "Mod 3 Project Groups", "Rails 🛤 CRUD App 👯‍♀️", "Mod 4 Project Groups", "Module 1 Project Groups", "Week 2 Week 1 Table Groups", "Allergen Lab 🤧", "App Roulette", "Mod 2 Project Groups"]

# 012720
# ["Sinatra ActiveRecord CRUD", "Deploy on Day 1", "OO Person", "Mod-1 week 1 table groups", "OO My Pets", "BYO Sinatra", "Project Euler", "Mod 2 Week 2 Table Groups", "Kick Starter", "AirBnB", "Mod-1 week 2 table groups", "BYO Many-to-Many", "Mid-Mod One Table Groups", "Mod 2 Week 1 Table Groups", "Mod-1-Final-Project", "Flatiron B&B Pair Lab", "Star Wars API"]

a1 = Activity.find_or_create_by(name: 'SWAPI', category: 'Lab', mod: 1)
a2 = Activity.find_or_create_by(name: 'Mod 1 Project', category: 'Project', mod: 1)
# a2 = Activity.find_or_create_by(name: 'Task Lister', category: 'Lab', mod: 3)
a3 = Activity.find_or_create_by(name: 'Toy Tale', category: 'Lab', mod: 3)
a4 = Activity.find_or_create_by(name: 'Mod 3 Project', category: 'Project', mod: 3)
a5 = Activity.find_or_create_by(name: 'Hogwarts', category: 'Lab', mod: 4)

date1 = Date.new(2019, 01, 28)
date2 = Date.new(2019, 02, 10)
date3 = Date.new(2019, 02, 13)
date4 = Date.new(2019, 02, 21)
date5 = Date.new(2019, 02, 28)


4.times do
  g1 = Group.create(activity_id: a1.id, notes: '', avoid: false, activity_date: date1, cohort_id: cohort.id)
  g2 = Group.create(activity_id: a2.id, notes: '', avoid: true, activity_date: date2, cohort_id: cohort.id)
  g3 = Group.create(activity_id: a3.id, notes: '', avoid: false, activity_date: date3, cohort_id: cohort.id)
  g4 = Group.create(activity_id: a4.id, notes: '', avoid: true, activity_date: date4, cohort_id: cohort.id)
  g5 = Group.create(activity_id: a5.id, notes: '', avoid: false, activity_date: date5, cohort_id: cohort.id)

  [2, 3].sample.times do
    StudentGroup.find_or_create_by(student_id: Student.all.sample.id, group_id: g1.id)
    StudentGroup.find_or_create_by(student_id: Student.all.sample.id, group_id: g2.id)
    StudentGroup.find_or_create_by(student_id: Student.all.sample.id, group_id: g3.id)
    StudentGroup.find_or_create_by(student_id: Student.all.sample.id, group_id: g4.id)
    StudentGroup.find_or_create_by(student_id: Student.all.sample.id, group_id: g5.id)
  end

end
