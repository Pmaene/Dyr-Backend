class Event
    include Mongoid::Document

    belongs_to :accessory
    belongs_to :user

    field :creationTime, type: Time, default: ->{ Time.now }
end
