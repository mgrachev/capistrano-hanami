namespace :deploy do
  task :set_hanami_env do
    set :hanami_env, (fetch(:hanami_env) || fetch(:stage))
  end
end

Capistrano::DSL.stages.each do |stage|
  after stage, 'deploy:set_hanami_env'
end

namespace :load do
  task :defaults do
    # Chruby, Rbenv and RVM integration
    append :chruby_map_bins, 'hanami'
    append :rbenv_map_bins, 'hanami'
    append :rvm_map_bins, 'hanami'

    # Bundler integration
    append :bundle_bins, 'hanami'
  end
end
