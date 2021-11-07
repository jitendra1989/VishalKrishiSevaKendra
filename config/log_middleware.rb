class LogMiddleware

  def initialize(app)
    @app = app
  end


  def call(env)
    puts"============LogMiddleware============="

    status  = 200
    headers = { "Content-Type" => "text/html" }
    body    = ["This is our small Rack app."]
    puts"============LogMiddleware 2============status == #{status}==headers==#{headers}=body==#{body}="
    [status, headers, body]
  end



end