module Healthcheck
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      if env['PATH_INFO'] == '/healthcheck'
        [ 200, { 'Content-Type' => 'application/json' }, [ body.to_json ] ]
      else
        @app.call env
      end
    end

    private
      def body
        _body = { status: 'ok' }
        _body[:commit] = ENV['GIT_COMMIT'].to_s unless ENV['GIT_COMMIT'].blank?
        _body
      end
  end
end
