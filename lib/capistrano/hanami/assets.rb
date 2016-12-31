namespace :deploy do
  desc 'Compile assets'
  task :compile_assets => [:set_hanami_env] do
    on release_roles(fetch(:assets_roles)) do
      within release_path do
        with hanami_env: fetch(:hanami_env) do
          execute :hanami, 'assets precompile'
        end
      end
    end
  end

  after 'deploy:updated', 'deploy:compile_assets'
end

# we can't set linked_dirs in load:defaults,
# as assets_prefix will always have a default value
namespace :deploy do
  task :set_linked_dirs do
    set :linked_dirs, fetch(:linked_dirs, []).push('public/assets').uniq
  end
end

after 'deploy:set_hanami_env', 'deploy:set_linked_dirs'

namespace :load do
  task :defaults do
    set :assets_roles, fetch(:assets_roles, [:web])
  end
end
