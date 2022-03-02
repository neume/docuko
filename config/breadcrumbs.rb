crumb :root do
  link 'Home', root_path
end

crumb :home do
  link 'Home', root_path
end

crumb :office do |office|
  link office.name, office_path(office.slug)
  parent :root
end

crumb :instances do |data_model|
  link data_model.name, office_data_model_instances_path(data_model.id, office_slug: data_model.office.slug)
  parent :office, data_model.office
end

crumb :edit_instance do |instance|
  data_model = instance.data_model
  link data_model.name, [data_model.office, instance.data_model]
  parent :office, data_model.office
end

crumb :new_instance do |data_model|
  link 'New'
  parent :instances, data_model
end

crumb :instance do |instance, office|
  link "Instance", office_instance_path(instance.id, office_slug: office.slug)
  parent :instances, instance.data_model
end


# Admin

crumb :office_admin do |office|
  link 'Admin', admin_office_path(office.slug)
  parent :office, office
end

crumb :edit_office do |office|
  link 'Edit'
  parent :office_admin, office
end

crumb :data_models do |office|
  link 'Data Models', office_data_models_path(office.slug)
  parent :office_admin, office
end

crumb :new_data_model do |office|
  link 'New'
  parent :office_admin, office
end

crumb :data_model do |data_model, office|
  link data_model.name, [office, data_model]
  parent :office_admin, office
end

crumb :edit_data_model do |data_model, office|
  link 'Edit'
  parent :data_model, data_model, office
end

crumb :edit_model_property do |model_property, office|
  link model_property.name, edit_office_model_property_path(model_property.id, office_slug: office.slug)
  parent :data_model, model_property.data_model, office
end

crumb :new_template do |data_model|
  office = data_model.office

  link 'New Template', [office, data_model]
  parent :data_model, data_model, office
end

crumb :edit_template do |template|
  data_model = template.data_model
  office = data_model.office

  link 'Edit Template', [:edit, office, template]
  parent :data_model, data_model, office
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
