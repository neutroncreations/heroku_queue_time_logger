module HerokuQueueTimeLogger
	class Railtie < Rails::Railtie
	  initializer "heroku_queue_time_logger.configure_rails_initialization" do |app|
	    app.middleware.insert 0, HerokuQueueTimeLogger::Middleware
	  end
	end
end