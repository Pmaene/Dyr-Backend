# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Include tasks from other gems included in your Gemfile
require "capistrano/bundler"
require "capistrano/rails"
require "capistrano/rbenv"
require "capistrano/secrets_yml"
require "capistrano/sidekiq"

set :rbenv_type, :user
set :rbenv_ruby, "2.2.0"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
