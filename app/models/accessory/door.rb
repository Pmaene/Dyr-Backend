class Door < Accessory
    field :host, type: String
    field :port, type: Integer

    field :nonce, type: Integer

    def url=(url)
        url.gsub!(/\/$/, "")
    end

    def nonce
        self[:nonce] += 1
        if self[:nonce] > (1 << 64)
            self[:nonce] = 0
        end

        self.save

        self[:nonce]
    end

    def nonce=(nonce)
        raise NotImplementedError
    end

    def hello
        ArduinoWorker.perform_async(self.host, self.port, self.nonce)
    end

end
