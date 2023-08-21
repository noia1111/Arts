class CheckDeletedUserMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['warden'].authenticated? && env['warden'].user.is_deleted
      env['warden'].logout
    end

    @app.call(env)
  end
end