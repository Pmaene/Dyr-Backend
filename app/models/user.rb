class User
    include Mongoid::Document

    devise :database_authenticatable,
           :recoverable,
           :validatable

    has_and_belongs_to_many :accessories
    has_many :events

    field :name,               type: String
    field :username,           type: String
    field :encrypted_password, type: String
    field :email,              type: String

    field :admin,              type: Boolean, default: false
end
