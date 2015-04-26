require "speck"

class Api::V1::Accessories::DoorsController < Api::V1::AccessoriesController
    before_action :check_access, only: [:create, :update, :destroy]
    before_action :set_door

    def switch
        if @door.nil?
            Redis.current.set "door", params[:id], options = {:ex => 10}

            @door = resource_class.find params[:id]

            if @door.hello
                Event.create!(
                    :user      => current_resource_owner,
                    :accessory => @door
                )

                Redis.current.del "door"

                render :json => {'status' => 'success'}
            else
                render :json => {'status' => 'error'}
            end
        else
            render :json => {'status' => 'busy'}
        end
    end

    protected

        def door_params
            params.permit :description, :name, :url
        end

        def query_params
            params.permit :user, :resource
        end

        def set_door
            if Redis.current.exists "door"
                @door = resource_class.find Redis.current.get('door')
            end
        end

end
