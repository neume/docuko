json.array! @users do |user|
  json.email user.email
  json.id user.id
end
