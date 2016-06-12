class Door < Accessory
    field :host,        type: String
    field :port,        type: Integer

    field :latitude,    type: Float
    field :longitude,   type: Float
    field :maxDistance, type: Float

    field :nonce,       type: Integer, default: 0

    def nonce(increment=true)
        self[:nonce] += 1 if increment
        if self[:nonce] > (1 << 64)
            self[:nonce] = 0
        end

        self.save

        self[:nonce]
    end

    def nonce=(nonce)
        raise NotImplementedError
    end

    def switch
        ArduinoWorker.perform_async self.host, self.port, self.nonce
    end
end
