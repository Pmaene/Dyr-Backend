json.array! @events do |event|
    json.partial! 'partials/event.json.jbuilder', event: event
end
