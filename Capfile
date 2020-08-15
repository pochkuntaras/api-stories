require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano/scm/git'
require 'capistrano/puma'

install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
