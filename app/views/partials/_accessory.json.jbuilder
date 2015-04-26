json.id          accessory.id.to_s
json.name        accessory.name
json.description accessory.description

if accessory.users.length > 0
    json.users accessory.users do |user|
        json.id user.id.to_s
    end
end
