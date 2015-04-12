require "speck"

class ArduinoWorker
    include Sidekiq::Worker
    include Sidekiq::Status::Worker

    sidekiq_options :retry => false

    def perform(host, port, nonce)
        total 3

        @host = host
        @port = port

        at 1, "hello"
        data = get_data("hello").split("/")

        if data[0] == "challenge"
            at 2, "challenge"

            speck = Speck.new "1b1a1918131211100b0a090803020100"
            ciphertext = data[1].to_i(16) ^ speck.enc("%016x" % nonce).to_i(16)

            nonce = "%016x" % nonce
            response = "%016x" % ciphertext

            data = get_data "switch/nonce/#{nonce}/response/#{response}"
            at 3, "response"
        else
            at 2, "unexpected input"
            logger.warn "unexpected input"
        end
    end

    def get_data(message)
        arduino = TCPSocket.new @host, @port

        arduino.send message, 0
        data = arduino.recv 4096;
        arduino.close

        data
    end
end
