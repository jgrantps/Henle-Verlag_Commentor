require_relative './config/environment.rb'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use CommentsController
use ComposersController
use UsersController
run ApplicationController
