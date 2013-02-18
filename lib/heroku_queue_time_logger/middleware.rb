module HerokuQueueTimeLogger

	# https://gist.github.com/a-warner/f5db30857ed3423cea79
	# combination of https://gist.github.com/daveyeu/4960893
	# and https://gist.github.com/jasonrclark/d82a1ea7695daac0b9ee
	class Middleware
	  DEFAULTS_OPTIONS = {
	    :perf_headers => true
	  }

	  def initialize app, options = {}
	    @options = DEFAULTS_OPTIONS.merge options
	    @app = app
	  end

	  def call env
	    now = Time.now.to_f

	    # Delete Heroku's queue time header because it's incorrect and useless
	    env.delete("HTTP_X_HEROKU_QUEUE_WAIT_TIME")

	    microseconds = (now * 1_000_000).to_i
	    env["HTTP_X_MIDDLEWARE_START"] = "t=#{microseconds}"

	    perf_headers = {}
	    if (request_start = env["HTTP_X_REQUEST_START"])
	      request_start_microseconds = request_start.gsub("t=", "").to_i * 1_000
	      queue_time_microseconds = [ microseconds - request_start_microseconds, 0 ].max
	      env["HTTP_X_QUEUE_TIME"] = "t=#{queue_time_microseconds}"

	      queue_time_milliseconds = (queue_time_microseconds / 1_000).to_i
	      perf_headers["X-Queue-Time"] = queue_time_milliseconds.to_s if @options[:perf_headers]
	    end

	    status, headers, body = @app.call(env)

	    [ status, headers.merge(perf_headers), body ]
	  end
	end
end