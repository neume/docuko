# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'admin@test', password: 'password')
User.create(email: 'user1@test', password: 'password')

office = Office.create(name: 'IT Services', slug: 'it-services', created_by: user, thumbnail_color: '#3dd')

member = office.members.create(user: user, member_role: :admin)

data_model = user.created_data_models.create(name: 'Project', created_by: user, office: office, thumbnail_color: '#868fc2')

properties = [
  { name: 'Project Name', code: 'project_name', header_visibility: true, required: true },
  { name: 'Date', code: 'date', header_visibility: true, required: true },
  { name: 'Description', code: 'description' },
  { name: 'Footnote', code: 'footnote' }
]

data_model.properties.create(properties)


400.times do
  instance_props = HashWithIndifferentAccess.new(
    project_name: Faker::Game.title,
    date: Faker::Date.between(from: '2018-01-01', to: '2022-05-04') ,
    description: Faker::Game.genre,
    footer: Faker::Lorem.paragraph
  )

  Instances::CreateService.execute(instance_props, data_model, user)
end

template = data_model.templates.new(name: 'Project Template')
file_path = File.open(Rails.root.join('spec/fixtures/files/project.docx'))

template.file.attach(
  io: file_path,
  filename: 'project.docx',
  content_type: 'file/docx'
)

template.save!

10.times do
  user.created_data_models.create(
    name: Faker::IndustrySegments.sector,
    description: Faker::Lorem.paragraph,
    office: office,
    thumbnail_color: '#3dd'
  )
end
