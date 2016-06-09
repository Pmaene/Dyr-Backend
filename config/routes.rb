Rails.application.routes.draw do
    use_doorkeeper do
    #    skip_controllers :authorized_applications
    #    controllers :applications => 'oauth_applications'
    end

    devise_for :users, skip: :all

    namespace :api do
        namespace :v1 do
            resources :events, :users

            namespace :accessories do
                resources :doors

                get '/doors/nonce/:name', to: 'doors#nonce', as: :doors_nonce
                post '/doors/switch', to: 'doors#switch', as: :doors_switch
                post '/doors/challenge', to: 'doors#challenge', as: :doors_challenge
            end
        end
    end
end
