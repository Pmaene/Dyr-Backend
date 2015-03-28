require "speck"

class ArduinoWorker
    include Sidekiq::Worker
    sidekiq_options :retry => false

    def perform(host, port, nonce)
        @host = host
        @port = port

        data = get_data("hello").split("/")

        if data[0] == "challenge"
            logger.info "challenge"

            speck = Speck.new("1b1a1918131211100b0a090803020100")
            ciphertext = data[1].to_i(16) ^ speck.enc("%016x" % nonce).to_i(16)

            nonce = "%016x" % nonce
            response = "%016x" % ciphertext

            data = get_data("switch/nonce/#{nonce}/response/#{response}")

            logger.info data
        else
            logger.warn "unexpected input"
        end
    end

    def get_data(message)
        arduino = TCPSocket.new(@host, @port)

        arduino.send(message, 0)
        data = arduino.recv(4096);
        arduino.close

        data
    end
end
