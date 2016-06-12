class Api::V1::EventsController < Api::V1::BaseController
    undef_method :create, :update, :destroy

    protected

        def door_params
            params.permit :accessory, :door, :user
        end

        def query_params
            params.permit :accessory, :user
        end
end
