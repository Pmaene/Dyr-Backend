json.id          accessory.id.to_s
json.name        accessory.name
json.description accessory.description

json.users accessory.users do |user|
  json.id user.id.to_s
end
