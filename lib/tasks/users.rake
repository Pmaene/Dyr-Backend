require "highline/import"

namespace :users do
    desc "Create a new user"
    task create: :environment do
        name = ask "Name: "
        email = ask "Email: "
        username = ask "Username: "

        if User.any_of({:email => email, :username => username}).exists?
            say "\n"
            say "<%= color('\u2718 A user with this email or username already exists', RED) %>"

            next
        end

        password = ask("Password: ") { |q| q.echo = false }
        repeat_password = ask("Repeat password: ") { |q| q.echo = false }

        if password != repeat_password
            say "\n"
            say "<%= color('\u2718 The passwords did not match', RED) %>"

            next
        end

        admin = agree "Admin [yes/no]: "

        user = User.create!(
            :name => name,
            :email => email,
            :username => username,
            :password => password,
            :admin => admin
        )

        say "\n"
        say "<%= color('\u2714 The user was created successfully', GREEN) %>"
    end

    desc "TODO"
    task update: :environment do
    end

    desc "TODO"
    task delete: :environment do
    end
end
