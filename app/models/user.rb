class User
    include Mongoid::Document

    devise :database_authenticatable,
           :recoverable,
           :trackable,
           :validatable

    field :username,           type: String
    field :encrypted_password, type: String
    field :email,              type: String

    field :sign_in_count,      type: Integer
    field :current_sign_in_at, type: Time
    field :last_sign_in_at,    type: Time
    field :current_sign_in_ip, type: String
    field :last_sign_in_ip,    type: String

    field :admin,              type: Boolean
end
