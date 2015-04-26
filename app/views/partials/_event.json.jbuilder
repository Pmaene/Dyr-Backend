json.id            event.id.to_s
json.creation_time event.creationTime.strftime("%Y-%m-%dT%H:%M:%S%z")
json.accessory     event.accessory.id.to_s

json.user do
    json.id    event.user.id.to_s
    json.name  event.user.name
end
