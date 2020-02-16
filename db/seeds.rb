# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Student.destroy_all

cohort = Cohort.find_or_create_by(batch: 'dc-web-102819', name: '|dreams|', batch_id: 1157, current_mod: 6)

10.times do
  Student.find_or_create_by(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, cohort_id: cohort.id)
end

projects = ['SWAPI', 'Toy Tale', 'Hogwarts', 'Task Lister', 'OO Pets']

10.times do
  s1 = Student.all.sample
  s2 = Student.all.sample
  proj = projects.sample
  Pair.find_or_create_by(s1_id: s1.id, s2_id: s2.id, mod: 1, name: proj, category: 'lab')
  Pair.find_or_create_by(s1_id: s2.id, s2_id: s1.id, mod: 1, name: proj, category: 'lab')
end