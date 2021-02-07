class WebSocketHandler < HTTP::WebSocketHandler
  @@actions = LuckyRouter::Matcher(BaseSocketAction.class).new

  def initialize
    @proc = ->proc(HTTP::WebSocket, HTTP::Server::Context)
  end

  def proc(w : HTTP::WebSocket, c : HTTP::Server::Context)
    match = @@actions.match("socket", c.request.path)
    if match.try(&.payload) && (action = match.not_nil!.payload) && (params = match.not_nil!.params)
      action.new(w, c, params).new_socket_connected
    else
      Log.dexter.error {
        {
          message: "Path not found. Closing the socket",
        }
      }
      w.close
    end
  end

  def self.actions
    @@actions
  end
end
