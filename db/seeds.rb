# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'admin@test', password: 'password')
User.create(email: 'user1@test', password: 'password')

office = Office.create(name: 'My Clinic', slug: 'my-clinic', created_by: user)

member = office.members.create(user: user, member_role: :admin)

data_model = user.created_data_models.create(name: 'Person', created_by: user, office: office)

properties = [
  { name: 'First Name', code: 'first_name', header_visibility: true },
  { name: 'Middle Name', code: 'middle_name', header_visibility: true },
  { name: 'Last Name', code: 'last_name', header_visibility: true },
  { name: 'Age', code: 'age', header_visibility: true }
]

data_model.properties.create(properties)


400.times do
  instance_props = HashWithIndifferentAccess.new(
    first_name: Faker::Name.first_name,
    middle_name: Faker::Name.middle_name,
    last_name: Faker::Name.last_name,
    age: rand(18..60)
  )
  CreateInstanceService.create(instance_props, data_model, user)
end

10.times do
  user.created_data_models.create(
    name: Faker::IndustrySegments.sector,
    description: Faker::Lorem.paragraph,
    office: office)
end
