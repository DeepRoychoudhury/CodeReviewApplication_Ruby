# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# #####################Development
    # require_relative 'config/application'
# 
   # Rails.application.load_tasks
# #####################Development

# #####################Production
   require File.expand_path('../config/application', __FILE__)
   CRA::Application.load_tasks
# #####################Production
# task :environment do
  # if Rails.env == 'production'
      # Rake::Task["db:structure:dump"].clear
  # end
# end
# # #####################Production
# begin
  # require 'minitest/autorun'
  # 
# rescue LoadError => e
  # raise e unless ENV['RAILS_ENV'] == "production"
# end
# 
      # task :environment do
        # ActiveSupport.on_load(:before_initialize) { config.eager_load = false }
		# require_environment!
        # ActiveRecord::Base.establish_connection(:production)
        # Rake::Task['db:seed'].invoke
		# Rake::Task['assets:precompile'].invoke
      # end

    # desc "Import old data in to new database"
    # task import_data: :environment  do |t, args|
      # ActiveRecord::Base.establish_connection(:production)
      # puts ActiveRecord::Base.connection.current_database
    # end