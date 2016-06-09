set :application, 'dyr'
set :repo_url, 'git@github.com:Pmaene/Dyr-Backend.git'

set :ssh_options, {:forward_agent => true}

set :deploy_to, '/opt/deploy/dyr'

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

set :stage, :production

server 'andromeda.local', user: 'deploy', roles: %w{web app}
