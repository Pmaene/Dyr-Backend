require 'speck'

class ArduinoWorker
    include Sidekiq::Worker

    sidekiq_options :retry => false

    def perform(host, port, nonce)
        @host = host
        @port = port

        speck = Speck.new Rails.application.secrets.arduino_key

        identifier = (host.gsub /\./, '').to_i
        token = speck.enc('%08x%08x' % [identifier, nonce])

        data = get_data "switch/nonce/#{'%08x' % nonce}/token/#{token}"

        raise 'error' if data == 'status/error'
    end

    def get_data(message)
        attempts = 0
        begin
            arduino = TCPSocket.new @host, @port

            arduino.send message, 0
            data = arduino.recv 4096;
            arduino.close
        rescue Errno::ECONNRESET => e
            attempts += 1
            retry unless attempts > 3

            data = ''
        end

        data
    end
end
