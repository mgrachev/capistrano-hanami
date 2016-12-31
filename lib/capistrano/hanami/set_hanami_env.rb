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
    set :bundle_bins, fetch(:bundle_bins, []).push('hanami').uniq
    set :rvm_map_bins, fetch(:rvm_map_bins, []).push('hanami').uniq
    set :rbenv_map_bins, fetch(:rbenv_map_bins, []).push('hanami').uniq
  end
end
