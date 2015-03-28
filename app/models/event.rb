class Event
    include Mongoid::Document

    has_one :user
    has_one :accessory

    field :creationTime, type: Time, default: ->{ Time.now }
    field :state, type: String
end
