namespace :deploy do
  desc 'Runs hanami db migrate if migrations are set'
  task :migrate => [:set_hanami_env] do
    on fetch(:migration_servers) do
      conditionally_migrate = fetch(:conditionally_migrate)
      info '[deploy:migrate] Checking changes in db' if conditionally_migrate
      if conditionally_migrate && test(:diff, "-qr #{release_path}/db #{current_path}/db")
        info '[deploy:migrate] Skip `deploy:migrate` (nothing changed in db)'
      else
        info '[deploy:migrate] Run `hanami db migrate`'
        invoke :'deploy:migrating' unless Rake::Task[:'deploy:migrating'].already_invoked
      end
    end
  end

  desc 'Runs hanami db migrate'
  task migrating: [:set_hanami_env] do
    on fetch(:migration_servers) do
      within release_path do
        with hanami_env: fetch(:hanami_env) do
          execute :hanami, 'db migrate'
        end
      end
    end
  end

  after 'deploy:updated', 'deploy:migrate'
end

namespace :load do
  task :defaults do
    set :conditionally_migrate, fetch(:conditionally_migrate, false)
    set :migration_role, fetch(:migration_role, :app)
    set :migration_servers, -> { primary(fetch(:migration_role)) }
  end
end
