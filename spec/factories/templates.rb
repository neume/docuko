FactoryBot.define do
  factory :template do
    name { 'MyString' }
    data_model

    after(:build) do |template|
      file_path = File.open(Rails.root.join('spec/fixtures/files/project.docx'))

      template.file.attach(
        io: file_path,
        filename: 'project.docx',
        content_type: 'file/docx'
      )
    end
  end
end
