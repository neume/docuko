# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(username: 'admin', password: 'password')

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


instance_props = HashWithIndifferentAccess.new(
  first_name: 'Juan',
  middle_name: 'Dimagiba',
  last_name: 'Dela Cruz',
  age: 25
)

CreateInstanceService.create(instance_props, data_model)
