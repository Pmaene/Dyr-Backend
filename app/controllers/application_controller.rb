class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session

    private

        def check_access
            if !current_user.admin?
                render :status => :unauthorized
            end
        end

end
