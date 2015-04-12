class Api::V1::EventsController < Api::V1::BaseController
    before_action :doorkeeper_authorize!
    undef_method :create, :update, :destroy

    private

        def door_params
            params.permit :accessory, :door, :user
        end

        def query_params
            params.permit :accessory, :user
        end

end
