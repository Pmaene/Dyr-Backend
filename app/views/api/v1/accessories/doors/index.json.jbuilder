json.array! @doors do |door|
    json.partial! 'partials/accessory.json.jbuilder', accessory: door

    json.latitude    door.latitude
    json.longitude   door.longitude
    json.maxDistance door.maxDistance
end
