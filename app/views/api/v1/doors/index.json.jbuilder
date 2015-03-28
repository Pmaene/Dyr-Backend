json.array! @doors do |door|
    json.partial! 'partials/accessory.json.jbuilder', accessory: door
end
