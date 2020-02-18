# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Student.destroy_all
Group.destroy_all
StudentGroup.destroy_all

cohort = Cohort.find_or_create_by(batch: 'dc-web-102819', name: '|dreams|', batch_id: 1157, current_mod: 6)

10.times do
  Student.find_or_create_by(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, cohort_id: cohort.id)
end

# projects = ['SWAPI', 'Toy Tale', 'Hogwarts', 'Task Lister', 'OO Pets']

a1 = Activity.find_or_create_by(name: 'SWAPI', category: 'Lab', mod: 1, cohort_id: cohort.id)
a2 = Activity.find_or_create_by(name: 'Task Lister', category: 'Lab', mod: 2, cohort_id: cohort.id)
a3 = Activity.find_or_create_by(name: 'Toy Tale', category: 'Lab', mod: 3, cohort_id: cohort.id)
a4 = Activity.find_or_create_by(name: 'Hogwarts', category: 'Lab', mod: 4, cohort_id: cohort.id)

4.times do
  g1 = Group.create(activity_id: a1.id)
  g2 = Group.create(activity_id: a2.id)
  g3 = Group.create(activity_id: a3.id)
  g4 = Group.create(activity_id: a4.id)

  [2, 3].sample.times do
    StudentGroup.find_or_create_by(student_id: Student.all.sample.id, group_id: g1.id)
    StudentGroup.find_or_create_by(student_id: Student.all.sample.id, group_id: g2.id)
    StudentGroup.find_or_create_by(student_id: Student.all.sample.id, group_id: g3.id)
    StudentGroup.find_or_create_by(student_id: Student.all.sample.id, group_id: g4.id)
  end

end
