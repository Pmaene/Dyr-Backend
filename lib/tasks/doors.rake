require "highline/import"

namespace :doors do
    desc "Create a new door"
    task create: :environment do
        name = ask "Name: "

        if Door.where(:name => name).exists?
            say "\n"
            say "<%= color('\u2718 A door with this name already exists', RED) %>"

            next
        end

        description = ask "Description: "

        host = ask("Host: ")
        port = ask("Port: ")

        if Door.where({:host => host, :port => port}).exists?
            say "\n"
            say "<%= color('\u2718 A door already exists on this host and port', RED) %>"

            next
        end

        user = Door.create!(
            :name => name,
            :description => description,
            :host => host,
            :port => port
        )

        say "\n"
        say "<%= color('\u2714 The door was created successfully', GREEN) %>"
    end

    desc "TODO"
    task update: :environment do
    end

    desc "TODO"
    task delete: :environment do
    end
end
