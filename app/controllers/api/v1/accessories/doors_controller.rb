require "speck"

class Api::V1::Accessories::DoorsController < Api::V1::BaseController
    before_action :doorkeeper_authorize!
    before_action :check_access, only: [:create, :update, :destroy]

    before_action :set_door

    def switch
        if @door.nil?
            Redis.current.set("door", params[:id], options = {:ex => 10})

            @door = resource_class.find(params[:id])
            @door.hello

            render :json => {'status' => 'success'}
        else
            render :json => {'status' => 'busy'}
        end
    end

    def challenge
        if @door.nil?
            return render :json => {'status' => 'premature'}
        end

        speck = Speck.new(Settings.arduino_key)
        ciphertext = params[:challenge].to_i(16) ^ speck.enc("%016x" % @door.nonce).to_i(16)

        @door.switch(@door.nonce, ciphertext)
        Redis.current.del("door")

        event = Event.create(
            user:      current_user,
            accessory: door
        )
        event.save

        render :json => {'status' => 'success'}
    end

    private

        def door_params
            params.permit(:description, :name, :url)
        end

        def query_params
            params.permit(:user, :resource)
        end

        def set_door
            if Redis.current.exists("door")
                @door = resource_class.find(Redis.current.get('door'))
            end
        end

end
