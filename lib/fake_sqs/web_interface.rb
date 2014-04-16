require 'sinatra/base'
require 'fake_sqs/catch_errors'
require 'fake_sqs/error_response'

module FakeSQS
  class WebInterface < Sinatra::Base

    configure do
      use FakeSQS::CatchErrors, response: ErrorResponse
    end

    helpers do

      def action
        params.fetch("Action")
      end

    end

    get "/" do
      200
    end

    get "/ping" do
      200
    end

    delete "/" do
      settings.api.reset
      200
    end

    put "/" do
      settings.api.expire
      200
    end

    post "/" do
      params['logger'] = logger
      if params['QueueUrl']
        queue = URI.parse(params['QueueUrl']).path.gsub(/\//, '')
        return settings.api.call(action, queue, params) unless queue.empty?
      end

      settings.api.call(action, params)
    end

    post "/:queue" do |queue|
      settings.api.call(action, queue, params)
    end

  end
end
