class Api::V1::UsersController < Api::V1::BaseController
    before_action :check_access, only: [:create, :update, :destroy]

    protected

        def user_params
            params.require :user
        end
end
